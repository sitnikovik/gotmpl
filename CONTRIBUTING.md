# Contributing

Thank you for your interest in this project! Here’s how you can help:

> [!IMPORTANT]
> Read [STYLE.MD](STYLE.MD) before writing code or opening a Pull Request.
> This repository uses a project-specific code style, and contributions are expected to follow it.

## Getting Started

Suggested workflow:

- Pick an open issue and work on it. Open a Pull Request that references the issue when you're ready
- If there is no suitable issue for your idea, open a short issue describing the proposal or contact the maintainer first
- Read [STYLE.MD](STYLE.MD) and follow the repository's code style before writing code
- Fork the repository and create a feature branch:

```bash
git checkout -b feature/your-feature
```

- Run and add tests for new behavior:

```bash
go test ./...
```

- Update `CHANGELOG.md` for user-visible changes and keep it in the [Keep a Changelog](https://keepachangelog.com/ru/1.0.0/) format
- Commit changes with a descriptive message, run the linters, and open a Pull Request
- If the PR passes review and checks, it can be merged and released

## Process

1. Open an issue if you propose a new feature or bugfix
or just get one of the already existing ones
2. Submit a pull request (PR) with a description of your changes

## Requirements

- Read and follow the repository style guide in [STYLE.MD](STYLE.MD)
- Setup pre-hooks
- Create branches only from issues
- Create issues with template
- Create pull request with template
- Keep `CHANGELOG.md` up to date in the [Keep a Changelog](https://keepachangelog.com/ru/1.0.0/) format
- Follow [Semantic Versioning](https://semver.org/lang/ru/) for each release,
and ensure every commit in the `master` branch is covered by a version tag created through the release process
- Run linters before opening a pull request

## Versioning and Release

This project uses [Semantic Versioning](https://semver.org/lang/ru/).
Every commit in the `master` branch must be associated with a product version tag.

Do not create release tags manually.
Use the `Release` GitHub Actions workflow instead:

1. Prepare `CHANGELOG.md` for the future version
in the [Keep a Changelog](https://keepachangelog.com/ru/1.0.0/) format
2. Run the `Release` workflow and pass the future version number without the `v` prefix
3. The workflow validates the version, extracts the matching section from `CHANGELOG.md`, creates a tag with the `v` prefix for the latest commit in `master`, and publishes the GitHub release with those changelog notes

## Code of Conduct

Be respectful and constructive. See [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md).

## Questions

Open an issue or contact the maintainers directly (see [README](README.md)).
