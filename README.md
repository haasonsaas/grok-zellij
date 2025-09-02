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

The `layout.yaml` file defines the pane structure. Edit it to customize your workspace:

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

## Requirements

- Bash
- Zellij
- GitHub CLI (for pushing updates)

## Contributing

Feel free to submit issues and pull requests.

## License

MIT License