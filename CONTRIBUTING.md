# Contributing

Thank you for your interest in this project!
Here’s how you can contribute to our project and help us make it even better.

> [!IMPORTANT]
> Read [STYLE.MD](STYLE.MD) before writing code or opening a Pull Request.
> This repository uses a project-specific code style, and contributions are expected to follow it.

## Requirements

TODO

## Getting Started

1. Clone the repository

    ```bash
    git clone https://github.com/yourusername/your-repo.git
    ```

2. Enter the directory of the cloned repository and run the script
to replace templates with your name

    ```bash
    sh ./scripts/itsme.sh <your_github_nickname> <your_github_repo>
    ```

3. [Pick an open issue](https://github.com/Ilya-Sitnikov/gotmpl/issues)
and work on it.

    If there is no suitable issue for your idea,
    open a short issue describing the proposal or contact the maintainer first

4. Fork the repository and create a feature branch:

    ```bash
    git checkout -b feature/your-feature
    ```

    > [!TIP]
    > You can also get the branch that GitHub suggests in the issue

5. Setup the project

    ```bash
    # Sets git hooks and recognize you in the project
    make setup
    ```

6. Commit your changes according to the [STYLE.MD](STYLE.MD)

    >[!IMPORTANT]
    > Use [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/)
    > or you commits would be rejected

7. Check the project before submitting a pull request

    ```bash
    # Runs all tests, linters and other checkers
    make check
    ```

    > [!TIP]
    > Some checkers run after commit or push
    and if you're sure you can skip this point
    and all checking will run in GitHub Actions

8. Update `CHANGELOG.md` for user-visible changes
and keep it in the [Keep a Changelog](https://keepachangelog.com/ru/1.0.0/) format

    > [!TIP]
    > Separate this changes in dedicated commit

    After you have done the code you have to describe what you have added or changed
    in `CHANGELOG.md` under the new version.
    If you're not sure with the suitable version number – you should discuss that with [maintainers](README.md#author--contact)

9. Submit a pull request with a [template](.github/pull_request_template.md)

    Your PR must pass all workflows
    and code review at least by one maintainer of the project.
    After successed, the maintainer merges your PR
    and creates a new project version.

## Versioning and Release

This project uses [Semantic Versioning](https://semver.org/lang/ru/).
Every commit in the main branch must be associated with a product version tag.

Do not create release tags manually.
Use the `Release` GitHub Actions workflow instead:

1. Prepare `CHANGELOG.md` for the future version
in the [Keep a Changelog](https://keepachangelog.com/ru/1.0.0/) format
2. Run the `Release` workflow and pass the future version number without the `v` prefix
3. The workflow validates the version, extracts the matching section from `CHANGELOG.md`, creates a tag with the `v` prefix for the latest commit in the main brach, and publishes the GitHub release with those changelog notes

## Code of Conduct

Be respectful and constructive. See [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md).

## Questions

Open an issue or contact the maintainers directly (see [README](README.md)).
