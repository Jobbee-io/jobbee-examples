#!/usr/bin/env bash
# PII scrub gate for Jobbee-io/jobbee-examples (runs in public CI).
# Checks GENERIC leak patterns only — this file itself is public, so
# it must never contain the specific markers it scans for.
# Founder-specific markers are checked by a LOCAL pre-push gate kept
# outside this repo. See scripts/scrub-why.md.
#
# Exit 1 = leak found; CI blocks. Exit 0 = clean.
set -uo pipefail

cd "$(dirname "$0")/.."
FAIL=0

# ── 1. Patterns ────────────────────────────────────────────────────
# Examples use fictional personas; contact info must be obviously
# fictional (@example.com, (555) phones, example.com URLs). Generic
# free-mail domains and US-formatted phone numbers fail so a
# copy-pasted real contact can never ship by accident.
PATTERNS=(
  '@gmail\.com'
  '@outlook\.com'
  '@yahoo\.com'
  '@hotmail\.com'
  '@icloud\.com'
  '@gmx\.'
  '@aol\.com'
  '@protonmail\.com'
  '@pm\.me'
  '[0-9][0-9][0-9][-. ][0-9][0-9][0-9][-. ][0-9][0-9][0-9][0-9]'
)
regex="$(IFS='|'; echo "${PATTERNS[*]}")"

# ── 2. Scan every tracked file ─────────────────────────────────────
while IFS= read -r -d '' f; do
  case "$f" in
    *.png|*.jpg|*.jpeg|*.gif|*.webp|*.pdf) continue ;;
  esac
  hits=$(grep -inEH "$regex" "$f" || true)
  if [[ -n "$hits" ]]; then
    echo "❌ SCRUB FAIL: $f"
    echo "$hits"
    FAIL=1
  fi
done < <(git ls-files -z)

# ── 3. Approved personas only ───────────────────────────────────────
allowed="maya-chen|diego-ramirez|sam-oaks|priya-anand|ravi-kulkarni|marcus-webb"
while IFS= read -r persona_dir; do
  [[ -z "$persona_dir" ]] && continue
  if ! [[ "$persona_dir" =~ ^($allowed)$ ]]; then
    echo "❌ SCRUB FAIL: unapproved persona dir examples/$persona_dir (allowed: $allowed)"
    FAIL=1
  fi
done < <(cd examples 2>/dev/null && ls -1 --color=never 2>/dev/null)

if [[ "$FAIL" -eq 1 ]]; then
  echo ""
  echo "Scrub gate FAILED — remove/replace the flagged content before merge."
  exit 1
fi

echo "✅ Scrub gate clean: no real-looking contact data; personas approved."
exit 0
