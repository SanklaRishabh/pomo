#!/bin/sh

# Create a help string.
USAGE="Usage: pomo [work|break|<TIME>]"

# Validate parameters.
if [ -z "$1" ]; then
  echo "$USAGE"
  exit 1
fi

# Determine the operating system type.
OS_NAME="$(uname)"

# Select interpreter to handle execution.
if [ "$OS_NAME" = "Darwin" ]; then
  /bin/zsh timer.sh "$1"
elif [ "$OS_NAME" = "Linux" ]; then
  /bin/bash timer.sh "$1"
else
  echo "Unsupported OS."
fi

exit 0