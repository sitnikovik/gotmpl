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
- Run linters before opening a pull request

## Code of Conduct

Be respectful and constructive. See [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md).

## Questions

Open an issue or contact the maintainers directly (see [README](README.md)).
