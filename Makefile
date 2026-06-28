.DEFAULT_GOAL = check

-include .github/ci.env

# Run all checks required to validate the codebase before merging.
.PHONY: check
check: test lint coverage-check

# Run all tests in the project.
.PHONY: test
test:
	@$(MAKE) unit-test || { \
		echo "❌ Unit tests failed; skipping integration tests"; \
		exit 1; \
	}
	@$(MAKE) integration-test

# Run unit tests.
.PHONY: unit-test
unit-test:
	@echo 🧪 Running unit tests...
	@pkgs=$$(go list ./... | grep -v './internal/test/integration$$'); \
	if [ -n "$$pkgs" ]; then \
		go test -race -count=1 $$pkgs; \
	else \
		echo "no packages to test"; \
	fi

# Run integration tests.
.PHONY: integration-test
integration-test:
	@echo 🧪 Running integration tests...
	@go test -tags=integration ./internal/test/integration/... -race -count=1

# Lint the codebase.
.PHONY: lint
lint:
	@golangci-lint run
	@./blackbox_tests_check.sh

# Generate coverage report from unit tests.
# Outputs total coverage percentage to tmp/coverage_total.out,
# covered lines to tmp/coverage_*.out
# and uncovered lines to tmp/uncovered.out.
.PHONY: coverage
coverage:
	@echo 🧪 Calculating test coverage...
	@sh scripts/coverage/report.sh

# Check if the total test coverage meets the defined threshold.
.PHONY: coverage-check
coverage-check:
	@echo 🧪 Checking test coverage...
	@COVERAGE_THRESHOLD=$(COVERAGE_THRESHOLD) sh scripts/coverage/check.sh
