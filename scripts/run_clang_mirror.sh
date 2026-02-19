#!/usr/bin/env bash
set -e

# Ensure libclang runtime exists (Ubuntu / Debian)
if ! ldconfig -p | grep -q "libclang-cpp"; then
    echo "libclang-cpp not found. Installing Clang/LLVM runtime..."
    sudo apt-get update
    sudo apt-get install -y clang libclang-cpp-dev llvm
fi

# Run clang-mirror (Linux)

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_ROOT="$( cd "$SCRIPT_DIR/.." && pwd )"

MIRROR_EXE="$PROJECT_ROOT/clang-mirror/clang-mirror"
SOURCE_LIST="$SCRIPT_DIR/reflection_srcs.txt"
OUT_DIR="$PROJECT_ROOT"

if [ ! -f "$MIRROR_EXE" ]; then
    echo "ERROR: clang-mirror not found."
    echo "Expected at:"
    echo "$MIRROR_EXE"
    exit 1
fi

if [ ! -f "$SOURCE_LIST" ]; then
    echo "ERROR: reflection_srcs.txt not found."
    echo "Expected at:"
    echo "$SOURCE_LIST"
    exit 1
fi

FILE_ARGS=""

while IFS= read -r LINE || [ -n "$LINE" ]; do
    if [ -z "$LINE" ]; then
        continue
    fi

    case "$LINE" in
        \#*) continue ;;
    esac

    FILE_ARGS="$FILE_ARGS \"$PROJECT_ROOT/$LINE\""
done < "$SOURCE_LIST"

echo
echo "Final command:"
echo "\"$MIRROR_EXE\" $FILE_ARGS -out-dir=\"$OUT_DIR\" -- -std=c++20 -fsyntax-only"
echo

eval "\"$MIRROR_EXE\" $FILE_ARGS -out-dir=\"$OUT_DIR\" -- -std=c++20 -fsyntax-only"

echo
echo "Reflection generation complete."
echo "Output directory:"
echo "$OUT_DIR"
echo
