#!/bin/bash

# Zellij setup script for project development

# Function to show usage
show_help() {
    echo "Usage: $0 [SESSION_NAME] [--layout FILE] [--config FILE] [--theme THEME] [--max-panes NUM] [--new] [--attach SESSION] [--verbose] [--help] [--list] [--dry-run] [--version] [--kill SESSION] [--kill-all]"
    echo "Launch or manage Zellij sessions with project layout."
    echo ""
    echo "Options:"
    echo "  SESSION_NAME    Name for the Zellij session (default: grok-project)"
    echo "  --layout FILE   Path to layout file (default: ./layout.yaml)"
    echo "  --config FILE   Path to config file"
    echo "  --theme THEME   Theme to use"
    echo "  --max-panes NUM Maximum number of panes"
    echo "  --new           Force creation of new session"
    echo "  --attach SESSION Attach to existing session"
    echo "  --verbose       Enable verbose output"
    echo "  --help          Show this help message"
    echo "  --list          List active Zellij sessions"
    echo "  --dry-run       Show the command that would be executed without running it"
    echo "  --version       Show Zellij version"
    echo "  --kill SESSION  Kill specific session"
    echo "  --kill-all      Kill and delete all Zellij sessions"
}

# Check if zellij is installed
if [ "$VERBOSE" = 1 ]; then echo "Checking Zellij installation..."; fi
if ! command -v zellij >/dev/null 2>&1; then
    echo "Error: Zellij is not installed. Please install Zellij first."
    exit 1
fi

# Set default layout path
LAYOUT_PATH="$(dirname "$0")/layout.yaml"

# Parse arguments
SESSION_NAME="grok-project"
DRY_RUN=0
ATTACH_SESSION=""
CONFIG_FILE=""
MAX_PANES=""
NEW_SESSION=0
THEME=""
VERBOSE=0
while [[ $# -gt 0 ]]; do
    case $1 in
        --help)
            show_help
            exit 0
            ;;
        --list)
            zellij list-sessions
            exit 0
            ;;
        --dry-run)
            DRY_RUN=1
            ;;
        --version)
            zellij --version
            exit 0
            ;;
        --layout)
            if [ -n "$2" ] && [ "${2:0:1}" != "-" ]; then
                LAYOUT_PATH="$2"
                shift
            else
                echo "Error: --layout requires a file path"
                exit 1
            fi
            ;;
        --config)
            if [ -n "$2" ] && [ "${2:0:1}" != "-" ]; then
                CONFIG_FILE="$2"
                shift
            else
                echo "Error: --config requires a file path"
                exit 1
            fi
            ;;
        --theme)
            if [ -n "$2" ] && [ "${2:0:1}" != "-" ]; then
                THEME="$2"
                shift
            else
                echo "Error: --theme requires a theme name"
                exit 1
            fi
            ;;
        --max-panes)
            if [ -n "$2" ] && [ "${2:0:1}" != "-" ]; then
                MAX_PANES="$2"
                shift
            else
                echo "Error: --max-panes requires a number"
                exit 1
            fi
            ;;
        --new)
            NEW_SESSION=1
            ;;
        --attach)
            if [ -n "$2" ] && [ "${2:0:1}" != "-" ]; then
                ATTACH_SESSION="$2"
                shift
            else
                echo "Error: --attach requires a session name"
                exit 1
            fi
            ;;
        --verbose)
            VERBOSE=1
            ;;
        --kill)
            if [ -n "$2" ] && [ "${2:0:1}" != "-" ]; then
                zellij kill-session "$2"
                exit 0
            else
                echo "Error: --kill requires a session name"
                exit 1
            fi
            ;;
        --kill-all)
            zellij delete-all-sessions --force --yes
            exit 0
            ;;
        *)
            SESSION_NAME="$1"
            ;;
    esac
    shift
done

# Check for conflicting options
if [ "$NEW_SESSION" = 1 ] && [ -n "$ATTACH_SESSION" ]; then
    echo "Error: --new cannot be used with --attach"
    exit 1
fi

# Check if layout file exists (only if not attaching)
if [ "$VERBOSE" = 1 ] && [ -z "$ATTACH_SESSION" ]; then echo "Checking layout file..."; fi
if [ -z "$ATTACH_SESSION" ] && [ ! -f "$LAYOUT_PATH" ]; then
    echo "Error: Layout file not found at $LAYOUT_PATH"
    exit 1
fi

# If dry run, show command
if [ "$DRY_RUN" = 1 ]; then
    CMD="zellij"
    if [ -n "$CONFIG_FILE" ]; then
        CMD="$CMD --config \"$CONFIG_FILE\""
    fi
    if [ -n "$THEME" ]; then
        CMD="$CMD --theme \"$THEME\""
    fi
    if [ -n "$MAX_PANES" ]; then
        CMD="$CMD --max-panes \"$MAX_PANES\""
    fi
    if [ "$NEW_SESSION" = 1 ]; then
        CMD="$CMD --new-session-with-layout \"$LAYOUT_PATH\" \"$SESSION_NAME\""
    elif [ -n "$ATTACH_SESSION" ]; then
        CMD="$CMD attach \"$ATTACH_SESSION\""
    else
        CMD="$CMD --layout \"$LAYOUT_PATH\" --session \"$SESSION_NAME\""
    fi
    echo "Would run: $CMD"
    exit 0
fi

# Check if running in a TTY
if [ "$VERBOSE" = 1 ]; then echo "Checking for TTY..."; fi
if [ ! -t 0 ]; then
    echo "Error: Zellij requires a TTY to run. Please run this script in a terminal."
    exit 1
fi

# All checks passed
if [ "$VERBOSE" = 1 ]; then echo "All checks passed. Proceeding..."; fi

# Launch or attach to Zellij session
if [ "$NEW_SESSION" = 1 ]; then
    CMD="zellij"
    if [ -n "$CONFIG_FILE" ]; then
        CMD="$CMD --config \"$CONFIG_FILE\""
    fi
    if [ -n "$THEME" ]; then
        CMD="$CMD --theme \"$THEME\""
    fi
    if [ -n "$MAX_PANES" ]; then
        CMD="$CMD --max-panes \"$MAX_PANES\""
    fi
    CMD="$CMD --new-session-with-layout \"$LAYOUT_PATH\" \"$SESSION_NAME\""
    eval "$CMD"
elif [ -n "$ATTACH_SESSION" ]; then
    CMD="zellij"
    if [ -n "$CONFIG_FILE" ]; then
        CMD="$CMD --config \"$CONFIG_FILE\""
    fi
    if [ -n "$THEME" ]; then
        CMD="$CMD --theme \"$THEME\""
    fi
    if [ -n "$MAX_PANES" ]; then
        CMD="$CMD --max-panes \"$MAX_PANES\""
    fi
    CMD="$CMD attach \"$ATTACH_SESSION\""
    eval "$CMD"
else
    CMD="zellij"
    if [ -n "$CONFIG_FILE" ]; then
        CMD="$CMD --config \"$CONFIG_FILE\""
    fi
    if [ -n "$THEME" ]; then
        CMD="$CMD --theme \"$THEME\""
    fi
    if [ -n "$MAX_PANES" ]; then
        CMD="$CMD --max-panes \"$MAX_PANES\""
    fi
    CMD="$CMD --layout \"$LAYOUT_PATH\" --session \"$SESSION_NAME\""
    eval "$CMD"
fi