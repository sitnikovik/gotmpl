.PHONY: setup
setup: itsme githooks reset-changelog

# Install Git hooks for automatic testing and linting.
.PHONY: githooks
githooks:
	@git config core.hooksPath .githooks
	@chmod +x .githooks/pre-commit .githooks/pre-push
	@echo "✅ Git hooks installed successfully"

# Replace all template substrings with developer credentials.
itsme:
	@sh ./scripts/itsme.sh

.PHONY: reset-changelog
reset-changelog:
	@set -e;
	@printf '%s\n' \
		'# Changelog' \
		'' \
		'All notable changes to this project will be documented in this file.' \
		'' \
		'The format is based on [Keep a Changelog](https://keepachangelog.com/en/2.0.0/),' \
		'and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).' \
		'' \
		'## [Unreleased]' \
		'' \
		'### Added' \
 		'' \
 		'### Changed' \
 		'' \
 		'### Deprecated' \
 		'' \
 		'### Removed' \
 		'' \
 		'### Fixed' \
 		'' \
 		'### Security' > CHANGELOG.md