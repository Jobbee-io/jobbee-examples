# Scrub gate policy — why these patterns

The public examples repo must never expose the founder's identity
(founder is intentionally pseudonymous) nor any real contact data.

## What the gate checks

1. **Real contact data** (public CI gate, `scripts/scrub-check.sh`) —
   examples use fictional personas; contact info in files must be
   obviously fictional (`@example.com`, placeholder phone style
   `(555) …`). Generic free-mail domains and US-formatted phone
   numbers fail the gate so a copy-pasted real contact can never ship
   by accident.
2. **Approved personas** (public CI gate, same script) — only
   approved fictional persona directories may exist under
   `examples/`. A stray copy of a real workspace fails the gate at
   the directory level.
3. **Founder markers** (LOCAL pre-push gate, never published) —
   name/handles/domains of the founder are scanned by a local-only
   script kept outside this repo. The public gate deliberately omits
   them: a public file containing the markers it scans for would
   itself publish them. Publish flow = local gate green → push.

## Adding a persona

1. Write the persona (fictional end-to-end).
2. Add its directory name to `allowed` in `scripts/scrub-check.sh` §2.
3. CI runs the public gate on every push and PR; the publisher runs
   the local founder gate before every push.
