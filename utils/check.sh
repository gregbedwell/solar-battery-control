#!/bin/bash
set -euo pipefail

# Color setup.
if [ -n "${TERM-}" ] && tput setaf 1 &>/dev/null; then
  BOLD=$(tput bold)
  RESET=$(tput sgr0)
  GREEN=$(tput setaf 2)
  CYAN=$(tput setaf 6)
else
  BOLD=""
  RESET=""
  GREEN=""
  CYAN=""
fi

# Directories to check.
TARGET_DIRS="src"

# uv invocation.
UV="uv run --extra dev"

print_section() {
  local name=$1
  echo
  echo "${BOLD}${CYAN}==> ${name}${RESET}"
}

print_success() {
  echo
  echo "${BOLD}${GREEN}✅ All checks passed!${RESET}"
  echo
}

# Handle --fix flag.
FIX=false
if [[ "${1:-}" == "--fix" ]]; then
  FIX=true
fi

if $FIX; then
  print_section "ruff format (applying fixes)"
  $UV ruff format $TARGET_DIRS

  print_section "ruff check --fix"
  $UV ruff check --fix $TARGET_DIRS
else
  print_section "ruff format (check only)"
  $UV ruff format --check $TARGET_DIRS

  print_section "ruff check"
  $UV ruff check $TARGET_DIRS
fi

print_section "mypy"
$UV mypy $TARGET_DIRS

print_success
