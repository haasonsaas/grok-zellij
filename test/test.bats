#!/usr/bin/env bats

# Tests for zellij-setup.sh

setup() {
    SCRIPT_DIR="$(cd "$(dirname "$BATS_TEST_DIRNAME")" && pwd)"
    SCRIPT="$SCRIPT_DIR/zellij-setup.sh"
}

@test "script exists and is executable" {
    [ -x "$SCRIPT" ]
}

@test "help option works" {
    run "$SCRIPT" --help
    [ "$status" -eq 0 ]
    [[ "$output" =~ "Usage:" ]]
}

@test "dry-run option works" {
    run "$SCRIPT" --dry-run
    [ "$status" -eq 0 ]
    [[ "$output" =~ "Would run:" ]]
}

@test "version option works" {
    run "$SCRIPT" --version
    [ "$status" -eq 0 ]
    [[ "$output" =~ "zellij" ]]
}

@test "invalid option shows error" {
    run "$SCRIPT" --invalid
    [ "$status" -ne 0 ]
}

@test "layout file validation" {
    run "$SCRIPT" --layout /nonexistent/file.yaml --dry-run
    [ "$status" -eq 1 ]
    [[ "$output" =~ "Layout file not found" ]]
}