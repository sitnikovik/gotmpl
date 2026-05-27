#!/bin/bash

set -euo pipefail

# Check that all *_test.go files use black-box testing package names.
# Black-box test files should have package names ending with _test.
# Exits with non-zero status if any violations are found.
# Usage: ./blackbox_tests_check.sh

failed=0
for f in $(find . -name '*_test.go'); do
  pkg=$(grep -E '^package ' "$f" | head -1 | awk '{print $2}')
  if [[ ! $pkg =~ _test$ ]]; then
    echo "$f — package '$pkg' should be renamed to '<name>_test' for black-box testing."
    failed=1
  fi
done
exit $failed