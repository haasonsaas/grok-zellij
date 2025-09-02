# Zellij Setup Script

A comprehensive bash script for managing Zellij terminal multiplexer sessions with custom layouts and configurations.

## Features

- Launch Zellij with custom layouts
- Attach to existing sessions
- Kill specific or all sessions
- Support for custom config files
- Force new session creation
- Pane limits
- Dry-run mode for testing
- Comprehensive error checking

## Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/haasonsaas/grok-zellij.git
   cd grok-zellij
   ```

2. Make the script executable:
   ```bash
   chmod +x zellij-setup.sh
   ```

3. Ensure Zellij is installed on your system.

## Usage

```bash
./zellij-setup.sh [SESSION_NAME] [OPTIONS]
```

### Options

- `SESSION_NAME`: Name for the Zellij session (default: grok-project)
- `--layout FILE`: Path to layout file (default: ./layout.yaml)
- `--config FILE`: Path to config file
- `--max-panes NUM`: Maximum number of panes
- `--new`: Force creation of new session
- `--attach SESSION`: Attach to existing session
- `--help`: Show help message
- `--list`: List active Zellij sessions
- `--dry-run`: Show command without executing
- `--version`: Show Zellij version
- `--kill SESSION`: Kill specific session
- `--kill-all`: Kill and delete all sessions

### Examples

Launch default session:
```bash
./zellij-setup.sh
```

Launch with custom session name:
```bash
./zellij-setup.sh my-project
```

Attach to existing session:
```bash
./zellij-setup.sh --attach my-session
```

Force new session:
```bash
./zellij-setup.sh --new my-new-session
```

Dry run to see command:
```bash
./zellij-setup.sh --dry-run --max-panes 5
```

List active sessions:
```bash
./zellij-setup.sh --list
```

## Layout Configuration

Layouts are stored in the `layouts/` directory. The default layout is `layouts/default.yaml`. You can specify custom layouts with `--layout`.

### Default Layout
```yaml
---
direction: Horizontal
parts:
  - direction: Vertical
    split_size:
      Percent: 70
    run:
      command: { cmd: bash }
  - run:
      command: { cmd: bash }
```

### Development Layout
For more complex setups, use `layouts/dev.yaml`:
```bash
./zellij-setup.sh --layout layouts/dev.yaml
```

## Development

Use the Makefile for common tasks:
```bash
make install    # Make script executable
make test       # Run tests
make lint       # Lint code
make format     # Format code
```

## Requirements

- Bash
- Zellij
- GitHub CLI (for pushing updates)

## Development

### Testing
Run the test suite:
```bash
bats test/
```

### Linting
Check code quality:
```bash
shellcheck zellij-setup.sh
```

### Formatting
Format the code:
```bash
shfmt -w zellij-setup.sh
```

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct and the process for submitting pull requests.

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for a list of changes.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.