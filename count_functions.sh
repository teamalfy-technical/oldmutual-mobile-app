#!/bin/bash

# Navigate to the project root (optional)
# cd /path/to/your/flutter/project

# Directory to scan
DIR="lib"

# Check if directory exists
if [ ! -d "$DIR" ]; then
  echo "Directory '$DIR' not found!"
  exit 1
fi

# Count Dart functions using regex
# Looks for patterns like:
#   void functionName(...)
#   returnType functionName(...)
#   functionName(...) { ... }
count=$(grep -rE '^[[:space:]]*(Future<.*>|Stream<.*>|[A-Za-z_<>?]+)?[[:space:]]+[A-Za-z_][A-Za-z0-9_]*\s*\([^)]*\)\s*\{' "$DIR" --include="*.dart" | wc -l)

echo "Total number of functions in '$DIR': $count"
