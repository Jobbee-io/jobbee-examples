<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Distributed KV store with Raft: senior capstone

Alder Ridge University, senior capstone (CS 4900, systems track), January to May 2026. Solo. Go, about 5,600 lines with tests. Chosen as one of 8 of 96 teams to demo at the capstone showcase. My resume has four lines on it. This file has the design decisions, the numbers and how I measured them, the bugs, and what I cut. It's the project I expect to be asked about most.

## Context

I took CS 3440 Distributed Systems in spring 2024 and TA'd it in fall 2024 and fall 2025. The capstone let systems-track students build on the CS 3440 lab framework, which provides transport and RPC plumbing only, on one condition: any Raft project had to pass the CS 3440 reference suite. Everything above the transport I wrote myself from the Raft paper and the course's guide notes. No consensus library.

Teams of 1 to 3 were allowed. I went solo. The professor warned me the report alone would take as long as the code. She was right (below).

## What it is

A replicated key-value store on a 3-to-5-node cluster. Raft underneath: leader election, log replication, persistence, snapshots, and single-server membership changes. The API:

- `get(key) → (value, error)`
- `put(key, value) → error`
- `delete(key) → error`
- `cas(key, expected, new) → (ok, error)`

`cas` was not in my plan. A classmate building a lock service on top for her own capstone needed it, and it forced the best design question of the project (below).

Where the 5,600 lines are: Raft core about 2,300; KV state machine and snapshots about 900; client library about 400; chaos harness and verifier about 800; tests about 1,200.

## How a node is built

Each node is one Go process. All Raft state (term, vote, log, commit index, role) is owned by a single event-loop goroutine that selects over incoming RPCs, timer events and client commands. Anything slow (fsync, sending RPCs, applying to the state machine) runs outside the loop and reports back on a channel.

That wasn't my first design. In week 2 I had one big mutex around the Raft state, and an RPC handler holding it while waiting on the apply channel deadlocked against the apply loop. I spent a day adding lock-ordering rules, then threw them out in week 5 and moved to the event loop. Since then there has been one place where state changes, and every deadlock I've hit since was a channel I forgot to drain, which shows up in a stack dump in seconds.

Persistence: term, vote and log go to an append-only file, with fsync before replying to any vote or append, as Raft requires. The leader batches client commands (every heartbeat, or at 64 pending) so one fsync covers many writes. Snapshots are written to a temp file and renamed into place, so a crash mid-snapshot leaves the old one intact.

## Design decisions, and why

**1. Reads use ReadIndex, not leases and not the log.** Three options:
- Leader leases: the leader answers reads locally while its lease holds. Fastest, but correctness depends on bounded clock drift, and the course guide takes marks off for lease mistakes for good reason.
- A no-op log entry per read: the most conservative. Every read pays a full replication round and an fsync on a majority.
- ReadIndex: the leader records its commit index, confirms it is still leader with one heartbeat round, waits until it has applied up to that index, then answers. No clock trust, no fsync. Reads that arrive while a confirmation round is in flight wait for the next round, so many reads share one round.

I chose ReadIndex on reasoning in February and only measured it in April (see the benchmark). The decision and the numbers are in `docs/design/reads.md` in the repo.

**2. `cas` goes through the log.** My first idea was to read the current value with ReadIndex and then submit a conditional put. That's wrong: another write can commit between the read and the put. `cas` is a log command, and the compare happens when the entry is applied, in log order, on every node. The same rule now applies to anything that reads and writes: it's a write.

**3. Snapshots every 10,000 entries, with a copy-on-write layer.** The state machine is a map. Serializing it while writes continue needed a copy-on-write overlay: during a snapshot, the base map is frozen and new writes go to the overlay, merged back when serialization finishes. Tested on one machine with up to 10M synthetic keys (about 600 MB; serialize about 4 seconds, restore about 7). Never tested with snapshot transfer over a real network.

**4. Membership: one server at a time.** Joint consensus is where capstone projects go to die. I implemented add-server and remove-server one at a time, the simpler approach from the Raft dissertation, and wrote down exactly what the cluster can't do: no reconfiguring several members in one step.

**5. Election timeouts 1.5 to 3 seconds, heartbeat 300 ms.** The lab network injects delays up to 200 ms and drops messages. When the professor asked why these numbers, my first answer was "they felt right", and she rejected it. The second answer was a measurement: 50 forced leader failures at 5 nodes under the lab's partition maps, for each timeout range.

- 0.5 to 1 s: median time to a stable leader 2.9 s, split votes in 31 of 50.
- 1 to 2 s: 2.6 s, split votes in 12 of 50.
- 1.5 to 3 s: 2.8 s, split votes in 4 of 50.

The middle range was slightly faster on median, but 1.5 to 3 s had the fewest split-vote storms, which were the source of the worst-case failovers. The cost: a clean failover takes 2 to 4 seconds.

## Timeline

- **January (weeks 1 to 3):** proposal, the solo decision, elections working by week 3.
- **February (weeks 4 to 7):** log replication and persistence; the event-loop rewrite in week 5; about 700 of the 1,200 reference scenarios passing by the end of the month.
- **March (weeks 8 to 11):** snapshots, membership, the KV API with `cas`. All 1,200 reference scenarios passing on March 20.
- **Late March to April (weeks 11 to 14):** the chaos harness, 40 soak runs, the 3 bugs below, and the benchmark.
- **May:** the report and the showcase demo, where I killed the leader while the counter client ran and the audience watched it recover.

## How I tested it

**The reference suite: 1,200 scenarios.** Every 2-versus-1 and 3-versus-2 partition at several message-drop rates, process kills at random points, delayed and reordered RPCs.

**My chaos soak, on top.** A script kills a random node every 2 to 8 seconds for 30 minutes and restarts it. Meanwhile one client writes an increasing counter, and a verifier reads it back and finally replays the client's acknowledged-write log against the final state. "Committed-write loss" means a put acknowledged to the client that is missing from the final state, or later replaced by an older value. 40 runs, zero committed-write loss.

**What the soak doesn't prove.** It has one sequential writer, so it can't detect a write applied twice (see client sessions, below), and it can't catch a stale read under concurrent clients. It proves acknowledged writes survive repeated kills. A real linearizability check over concurrent histories would be stronger. I knew that and shipped the simple verifier because of the deadline. It's in the report as a known limit.

## The three bugs the soak found

1. **Snapshot restore dropped the last-applied index (run 6).** A node restoring from a snapshot could re-apply entries already inside the snapshot, and conflicting overwrites corrupted the map. The verifier caught it. Fix: restore sets last-applied from the snapshot's metadata before the apply loop starts. The failing sequence became its own regression scenario.
2. **Split votes forever after restarts.** My timeout randomization seeded its generator the same way on every process start, so two nodes restarted together picked the same timeout and split votes in a loop. Fix: seed per node and per start. A classic bug, and now my favorite story about randomness.
3. **`cas` during a snapshot (run 31).** The compare step read through the copy-on-write layer, which checked the frozen base before the overlay. A key written after the snapshot started could be compared against its old value. Rare and real. Fix: lookups check the overlay first, under the same read lock writes use.

## The benchmark

Written in April. 3 nodes as processes on my laptop (8 cores, one SSD), 16 concurrent clients, 60-second runs, median of 5.

- Read-only: about 1,900 reads per second with a no-op entry per read; about 11,500 with ReadIndex. Roughly 6 times.
- Writes: about 1,400 puts per second at 3 nodes, about 1,100 at 5, limited by fsync.

All nodes share one machine and one disk, so these numbers compare my own options. They say nothing about a real deployment.

## What I cut

- **Client sessions (exactly-once).** Without them, a client that retries a put after a lost reply can get it applied twice. For a plain put of the same value that's harmless; for anything conditional it isn't. The fix is a client ID and sequence number per request, deduplicated in the state machine.
- **Joint consensus** for changing several members at once.
- **Lease reads** with explicit clock-drift bounds.

I can explain each design on a whiteboard. I haven't built any of them. My estimate is 2 to 3 weeks each.

## What I'd do differently

- **Benchmark in February.** The read-path decision was right, but it had numbers only after it was built. Measuring first would have taken 2 days.
- **Start with the event loop.** The mutex version cost me about a week across weeks 2 to 5.
- **Solo was right for learning and wrong for the report.** The write-up took as long as the code. A partner would have split it, and a peer review would have caught my habit of describing what the code does instead of why it's shaped that way.
- **Build the linearizability check,** even a small one. The soak's blind spots are exactly where Raft implementations are usually wrong.
