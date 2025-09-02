# Makefile for Zellij Setup Script

.PHONY: help install test lint format clean

# Default target
help:
	@echo "Available targets:"
	@echo "  install    - Make script executable"
	@echo "  test       - Run test suite"
	@echo "  lint       - Run ShellCheck"
	@echo "  format     - Format code with shfmt"
	@echo "  clean      - Remove generated files"
	@echo "  help       - Show this help"

# Install script
install:
	chmod +x zellij-setup.sh

# Run tests
test:
	@if command -v bats >/dev/null 2>&1; then \
		bats test/; \
	else \
		echo "Bats not installed. Install with: sudo apt-get install bats"; \
	fi

# Lint code
lint:
	@if command -v shellcheck >/dev/null 2>&1; then \
		shellcheck zellij-setup.sh; \
	else \
		echo "ShellCheck not installed. Install with: sudo apt-get install shellcheck"; \
	fi

# Format code
format:
	@if command -v shfmt >/dev/null 2>&1; then \
		shfmt -w zellij-setup.sh; \
	else \
		echo "shfmt not installed. Install from: https://github.com/mvdan/sh/releases"; \
	fi

# Clean up
clean:
	rm -f *.log
	find . -name "*.tmp" -delete