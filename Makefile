.DEFAULT_GOAL = check

-include .github/ci.env

# Run all checks required to validate the codebase before merging.
.PHONY: check
check: test lint coverage-check

# Install Git hooks for automatic testing and linting.
.PHONY: githooks
githooks:
	@git config core.hooksPath .githooks
	@chmod +x .githooks/pre-commit .githooks/pre-push
	@echo "✅ Git hooks installed successfully"

# Run all tests in the project.
.PHONY: test
test: unit-test

# Run unit tests.
.PHONY: unit-test
unit-test:
	@echo 🧪 Running unit tests...
	@mkdir -p tmp
	@pkgs=$$(go list ./... | grep -v 'internal/test/integration' | grep -v 'internal/test/fake'); \
	if [ -n "$$pkgs" ]; then \
		go test -race -count=1 \
		-covermode=atomic \
		-coverprofile=../tmp/coverage_unit.out \
		$$pkgs; \
	else \
		echo "no packages to test"; \
	fi \

# Lint the codebase.
.PHONY: lint
lint:
	@golangci-lint run ./...

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
