#!/usr/bin/env bash
# PII scrub gate for Jobbee-io/jobbee-examples (runs in public CI).
# Checks generic leak patterns only: contact data that looks real, and
# persona folders not on the allow-list.
# Real people's identity is checked by each change's author before it is
# published. See scripts/scrub-why.md.
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

# ── 2b. Binary files ───────────────────────────────────────────────
# Binary files carry hidden metadata. The one kind allowed is a demo's
# resume PDF, written plainly: no document metadata, and none of the parts
# that could hide it or act on open (compressed object lists, escaped
# names, attachments, scripts, links).
PDF_REFUSED='/(Info|ObjStm|XRef|Metadata|EmbeddedFiles?|JavaScript|JS|OpenAction|AA|URI|PieceInfo|Title|Author|Subject|Keywords|Creator|Producer|CreationDate|ModDate)[^A-Za-z]|/[A-Za-z0-9]*#[0-9A-Fa-f]{2}'
# Decided by path: the allowed path is always checked, whatever the file
# looks like; anywhere else, a binary-type name, a PDF header or binary
# content fails.
while IFS= read -r -d '' f; do
  [[ -s "$f" ]] || continue
  head5="$(LC_ALL=C head -c 5 "$f")"
  if [[ "$f" =~ ^demos/[^/]+/tailored-resume\.pdf$ ]]; then
    if [[ "$head5" != "%PDF-" ]] || LC_ALL=C grep -a -q -E "$PDF_REFUSED" "$f"; then
      echo "❌ SCRUB FAIL: $f carries document metadata or parts that can hide it"
      FAIL=1
    fi
  elif [[ "$(printf %s "$f" | tr "[:upper:]" "[:lower:]")" =~ \.(pdf|png|jpe?g|gif|webp|ico|bmp|tiff?|heic|zip|gz|docx|xlsx|pptx)$ || "$head5" == "%PDF-" ]] || ! LC_ALL=C grep -Iq . "$f"; then
    echo "❌ SCRUB FAIL: binary file $f (the only one allowed is demos/<demo>/tailored-resume.pdf)"
    FAIL=1
  fi
done < <(git ls-files -z)

# ── 3. Approved personas only ───────────────────────────────────────
allowed="maya-chen|diego-ramirez|sam-oaks|priya-anand|ravi-kulkarni|marcus-webb|elena-vargas|dana-whitfield|kenji-sato|aisha-okafor|lena-hoffmann|nadia-saliba|rohan-ghaisas|grace-liu|paul-brennan|ana-kowalska|rebecca-thornbury|daniel-osei|harriet-cole|joelle-ashworth|isaac-fenwick|marisol-salcido|megan-albright|jonah-pruett"
while IFS= read -r persona_dir; do
  [[ -z "$persona_dir" ]] && continue
  if ! [[ "$persona_dir" =~ ^($allowed)$ ]]; then
    echo "❌ SCRUB FAIL: unapproved persona dir examples/$persona_dir (allowed: $allowed)"
    FAIL=1
  fi
done < <(cd examples 2>/dev/null && ls -1 --color=never 2>/dev/null)

# Demo folders belong to an approved persona: demos/<persona>--<job>/
while IFS= read -r demo_dir; do
  [[ -z "$demo_dir" ]] && continue
  if ! [[ "$demo_dir" =~ ^($allowed)--[a-z0-9-]+$ ]]; then
    echo "❌ SCRUB FAIL: demo dir demos/$demo_dir is not <approved persona>--<job> (allowed personas: $allowed)"
    FAIL=1
  fi
done < <(cd demos 2>/dev/null && ls -1 --color=never 2>/dev/null)

if [[ "$FAIL" -eq 1 ]]; then
  echo ""
  echo "Scrub gate FAILED — remove/replace the flagged content before merge."
  exit 1
fi

echo "✅ Scrub gate clean: no real-looking contact data; personas approved."
exit 0
