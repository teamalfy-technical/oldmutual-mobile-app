#!/bin/bash

BASE_DIR="lib"

if [ ! -d "$BASE_DIR" ]; then
  echo "❌ Directory '$BASE_DIR' not found!"
  exit 1
fi

echo "🔍 Scanning '*.vm.dart' files under $BASE_DIR for 'Future<void>' functions..."
echo "--------------------------------------------------------------"

# Find all .vm.dart files
FILES=$(find "$BASE_DIR" -type f -name "*.vm.dart")

total_functions=0
total_params=0

for file in $FILES; do
  # Find all function definitions with Future<void>
  matches=$(grep -Eo "Future<void>[[:space:]]+[a-zA-Z0-9_]+\([^)]*\)" "$file")

  # Count how many Future<void> functions exist in this file
  func_count=$(echo "$matches" | grep -c "Future<void>")
  total_functions=$((total_functions + func_count))

  # Count approximate parameters (count commas + 1 per function)
  param_count=0
  while read -r line; do
    if [[ -n "$line" ]]; then
      # Extract inside the parentheses
      inside=$(echo "$line" | sed -E 's/.*\((.*)\).*/\1/')
      # If not empty, count commas + 1
      if [[ -n "$inside" && "$inside" != " " ]]; then
        commas=$(echo "$inside" | grep -o "," | wc -l)
        params=$((commas + 1))
        param_count=$((param_count + params))
      fi
    fi
  done <<< "$matches"

  total_params=$((total_params + param_count))

  echo "📄 $(basename "$file") → Functions: $func_count | Params ≈ $param_count"
done

echo "--------------------------------------------------------------"
echo "✅ Summary across all '*.vm.dart' files:"
echo "Total Future<void> functions: $total_functions"
echo "Approx. total parameters: $total_params"
if [ $total_functions -gt 0 ]; then
  avg=$(echo "$total_params / $total_functions" | bc -l)
  printf "Average Parameters per Function: %.2f\n" "$avg"
fi
echo "--------------------------------------------------------------"
