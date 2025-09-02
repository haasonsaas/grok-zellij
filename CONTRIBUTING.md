# Contributing

Thank you for your interest in contributing to the Zellij Setup Script! This document provides guidelines for contributing to the project.

## Development Setup

1. Fork the repository
2. Clone your fork: `git clone https://github.com/YOUR_USERNAME/grok-zellij.git`
3. Create a feature branch: `git checkout -b feature/your-feature`
4. Make your changes
5. Run tests: `bats test/`
6. Run linting: `shellcheck zellij-setup.sh`
7. Format code: `shfmt -w zellij-setup.sh`
8. Commit your changes: `git commit -m "Add your feature"`
9. Push to your fork: `git push origin feature/your-feature`
10. Create a Pull Request

## Code Style

- Follow POSIX shell standards
- Use `shfmt` for formatting
- Pass ShellCheck linting
- Add comments for complex logic
- Use meaningful variable names

## Testing

- Add tests for new features in `test/test.bats`
- Ensure all tests pass before submitting
- Test on Ubuntu/Debian systems

## Documentation

- Update README.md for new features
- Update CHANGELOG.md with changes
- Add examples for complex features

## Commit Messages

- Use clear, descriptive commit messages
- Follow conventional commit format when possible:
  - `feat:` for new features
  - `fix:` for bug fixes
  - `docs:` for documentation
  - `test:` for tests
  - `refactor:` for code refactoring

## Issues

- Check existing issues before creating new ones
- Provide detailed reproduction steps for bugs
- Suggest improvements with rationale

## Code of Conduct

- Be respectful and inclusive
- Focus on constructive feedback
- Help maintain a positive community

## License

By contributing, you agree that your contributions will be licensed under the same license as the project (MIT).