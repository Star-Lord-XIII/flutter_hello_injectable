#!/bin/bash

set -e

DIR="${BASH_SOURCE%/*}"
source "$DIR/flutter_ci_script_shared.sh"

flutter doctor -v

declare -ar PROJECT_NAMES=(
    "package/hello_spec"
    "."
)

ci_projects "stable" "${PROJECT_NAMES[@]}"

echo "-- Success --"