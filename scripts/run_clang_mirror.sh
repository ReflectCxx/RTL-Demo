#!/usr/bin/env bash
set -e

# Ensure LLVM 21 runtime exists
if ! ldconfig -p | grep -q "libclang-cpp.so.21"; then
    echo "LLVM 21 not found. Installing..."

    sudo apt-get update
    sudo apt-get install -y \
        wget \
        gnupg \
        lsb-release \
        software-properties-common

    wget https://apt.llvm.org/llvm.sh
    chmod +x llvm.sh
    sudo ./llvm.sh 21

    sudo apt-get update
    sudo apt-get install -y \
        ninja-build \
        clang-21 \
        clang-tools-21 \
        llvm-21-dev \
        libclang-21-dev
fi

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_ROOT="$( cd "$SCRIPT_DIR/.." && pwd )"

MIRROR_EXE="$PROJECT_ROOT/clang-mirror/clang-mirror"
SOURCE_LIST="$SCRIPT_DIR/reflection_srcs.txt"
OUT_DIR="$PROJECT_ROOT"

if [ ! -f "$MIRROR_EXE" ]; then
    echo "ERROR: clang-mirror not found."
    echo "$MIRROR_EXE"
    exit 1
fi

if [ ! -f "$SOURCE_LIST" ]; then
    echo "ERROR: reflection_srcs.txt not found."
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
echo "Running:"
echo "\"$MIRROR_EXE\" $FILE_ARGS -out-dir=\"$OUT_DIR\" -- -std=c++20 -fsyntax-only"
echo

eval "\"$MIRROR_EXE\" $FILE_ARGS -out-dir=\"$OUT_DIR\" -- -std=c++20 -fsyntax-only"

echo
echo "Reflection generation complete."
echo "$OUT_DIR"
echo