<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Distributed KV store with Raft — CS 3440 capstone

Jan–May 2026, Alder Ridge University, CS 3440 Distributed Systems capstone. Solo project (teams of 1–3 allowed; I went solo, which the professor warned me about and I did it anyway). Go, ~5,600 lines with tests. Chosen as one of 8 of 96 teams to demo at the course showcase.

## What it is

A replicated key-value store: 3-to-5-node cluster, Raft consensus underneath (elections, log replication, snapshotting), linearizable get/put behind the course's gRPC-ish framework interface. Not Raft-from-a-library — we implemented the consensus layer ourselves against the Raft paper + the course's guide notes; the framework gave us transport and RPC plumbing only.

**API:** `get(key) → (value, error)`, `put(key, value) → error`, `delete(key) → error`, plus `cas(key, expected, new)` because a classmate building on top needed it and it flushed out real design questions about linearizability.

## The design decisions, and why

**1. Every read goes through the log (no lease-based reads).**
The easy fast path — leader answers reads locally between heartbeats with a time-based lease — is the classic stale-read trap, and the course's guide explicitly docks for lease subtleties done wrong. I chose **ReadIndex-style reads**: leader confirms leadership with a heartbeat round, then answers. Still not through-the-log for every byte, but no clock trust. The fully-conservative option (append a no-op log entry per read) was my fallback, and the benchmark told me ReadIndex gave me ~6× read throughput at 3 nodes for one extra heartbeat round trip. Decision recorded in `docs/design/reads.md` in the repo, with the benchmark numbers attached.

**2. Snapshotting with copy-on-write state machine.**
Log compaction via snapshots every 10K entries. The state machine is a simple B-tree-ish map, so snapshotting is "serialize the map" — I added a copy-on-write layer so snapshot serialization doesn't stall writes. Honest note: this is tested at toy scale (10M keys synthetic), not at anything resembling production scale, and my snapshot *restore* path had a bug that fault injection caught (below).

**3. Membership changes: single-server additive only.**
The paper's joint-consensus chapter is where capstone projects go to die. I implemented add-server/remove-server one at a time (the simpler single-server-change approach from the Raft dissertation) and documented exactly what my cluster can't do: no wholesale reconfiguration in one step. Scope cut, recorded, defended in the final report.

**4. Timing: randomized election timeouts 1.5–3s, heartbeat 300ms.**
Picked after measuring: at 5 nodes, election storms during the lab's artificial network partitions settled fastest with this spread. I re-derived the numbers when the professor asked "why these?" and my first answer ("they felt right") was rejected, rightly. The second answer had a table.

## Failure injection — what I actually tested

The course's reference suite: **1,200 scenarios** — partition maps (every 2-vs-1 and 3-vs-2 split at various message-drop rates), process kills at random points in the state machine, delayed/reordered RPCs.

My own harness on top: a **chaos soak script** that kills a random node every 2–8 seconds for 30 minutes while a client writes a monotonically increasing counter and a verifier reads it back. **40 runs, zero committed-write loss** (the counter never went backwards; the verifier replays the write log against the final state). Found three real bugs across those 40 runs:

1. **Snapshot restore dropped the last-applied index** — a node restoring from snapshot could re-apply already-snapshotted entries, corrupting the map on conflicting overwrites. Found on chaos run #6 by the verifier, fixed, then the fix got its own regression scenario in the suite.
2. **Vote-splitting under clock jitter** — my first timeout randomization reused the same seed per process start, so two restarted nodes could share a timeout and split votes in a loop. Embarrassing, classic, now a favorite war story.
3. **CAS under concurrent snapshot** — the compare-and-swap read of current state raced with the COW snapshot; rare (caught on run #31), real, fixed with a proper read lock.

## What I'd do differently (the honest section)

- **The benchmark came too late.** I tuned the ReadIndex decision with a benchmark I wrote in April. Had I written it in February, the read-path design conversation would've had numbers from day one. Numbers early, always.
- **Solo was the wrong call for the *report*, even if it was right for the learning.** The writeup took me as long as the implementation. A partner would've split that, and reviews from a peer would've caught my docs' habit of explaining what the code does instead of why it's shaped that way.
- **Linearizability checking was ad hoc.** My verifier replays a linear history; a proper linearizability checker (like the course's mention of Wing & Gong style) over concurrent histories would be stronger evidence. I knew this and shipped the simple thing anyway — deadline realism, documented.
- **Group membership beyond single-server changes** and **client session dedup** (exactly-once client semantics) are the two features I cut that a real system must have. I can explain both designs on a whiteboard; I have not built either.

## What I can defend line-by-line in an interview

Election safety properties and where my code enforces them; why ReadIndex beats lease reads without clocks; the three bugs above, each with the scenario that caught it; the benchmark table for read throughput; the scope cuts and what they'd cost to un-cut (~2–3 weeks each, my estimate).
