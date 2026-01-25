# Contributing

Thank you for your interest in this project! Here’s how you can help:

## Getting Started

- Install Go (see README)
- Install make and golangci-lint (see README)
- Clone the repository and create a new branch:  
  ```bash
  git checkout -b feature/your-feature
  ```

## Process

1. Open an issue if you propose a new feature or bugfix.
2. Submit a pull request (PR) with a description of your changes.
3. Before submitting a PR:
   - Run tests:  
     ```bash
     make test
     ```
   - Run the linter:  
     ```bash
     make lint
     ```
   - Check coverage:  
     ```bash
     make coverage-check
     ```

## Requirements

- Follow the code style (golangci-lint)
- 
- Write tests for new features
- Do not decrease test coverage

## Code of Conduct

Be respectful and constructive. See [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md) for details (if available).

## Questions

Open an issue or contact the maintainer directly (see README).