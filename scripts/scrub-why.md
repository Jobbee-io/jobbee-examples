# Scrub gate policy — why these patterns

The public examples repo must never contain a real person's identity
or real contact data.

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
   the directory level. Each folder under `demos/` must be named
   `<approved persona>--<job>`, so a demo is always a persona's.
3. **Binary files** (public CI gate, same script) — binary files carry
   hidden metadata, so none are allowed except a demo's
   `tailored-resume.pdf`, and that file must carry no document
   metadata.
4. **Real people** (not a script) — every change is reviewed by its
   author before it is published.

## Adding a persona

1. Write the persona (fictional end-to-end).
2. Add its directory name to `allowed` in `scripts/scrub-check.sh` §3.
3. CI runs the public gate on every push and PR.
