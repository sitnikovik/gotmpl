#!/usr/bin/env sh
set -eu

# Validate coverage against COVERAGE_THRESHOLD; generate coverage if missing.
# Env:
#   COVERAGE_THRESHOLD - integer percentage (e.g., 90)
# Usage: ./coverage_check.sh

THRESHOLD=${COVERAGE_THRESHOLD:-80}
OUT_DIR=tmp
TOTAL_FILE="$OUT_DIR/coverage_total.out"

# Ensure coverage is generated
if [ ! -f "$TOTAL_FILE" ]; then
  echo "Generating coverage..."
  make coverage >/dev/null 2>&1 || true
fi

if [ ! -f "$TOTAL_FILE" ]; then
  echo "No coverage data found; treating as 0%"
  TOTAL=0
else
  TOTAL=$(cat "$TOTAL_FILE" | tr -d '\n' | tr -d ' ')
  case "$TOTAL" in
    '' ) TOTAL=0 ;;
    *[!0-9]*) TOTAL=0 ;;
  esac
fi

printf "Coverage threshold: %s%%\n" "$THRESHOLD"
printf "Coverage total:     %s%%\n" "$TOTAL"

if [ "$TOTAL" -lt "$THRESHOLD" ]; then
  echo "❌ Coverage below threshold"
  exit 1
fi

echo "✅ Coverage meets threshold"
