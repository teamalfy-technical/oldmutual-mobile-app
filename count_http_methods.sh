#!/bin/bash

# Base directory (Flutter lib)
BASE_DIR="lib"

# Check directory exists
if [ ! -d "$BASE_DIR" ]; then
  echo "❌ Directory '$BASE_DIR' not found!"
  exit 1
fi

echo "🔍 Scanning for '*.ds.impl.dart' files under $BASE_DIR..."
echo "--------------------------------------------------------------"

# Find all files ending with .ds.impl.dart
FILES=$(find "$BASE_DIR" -type f -name "*.ds.impl.dart")

# Initialize counters
total_get=0
total_post=0
total_put=0
total_delete=0

# Loop through each file
for file in $FILES; do
  get_count=$(grep -o "RequestType\.get" "$file" | wc -l)
  post_count=$(grep -o "RequestType\.post" "$file" | wc -l)
  put_count=$(grep -o "RequestType\.put" "$file" | wc -l)
  delete_count=$(grep -o "RequestType\.delete" "$file" | wc -l)

  total_get=$((total_get + get_count))
  total_post=$((total_post + post_count))
  total_put=$((total_put + put_count))
  total_delete=$((total_delete + delete_count))

  echo "📄 $(basename "$file") → GET: $get_count | POST: $post_count | PUT: $put_count | DELETE: $delete_count"
done

echo "--------------------------------------------------------------"
echo "✅ Approximate total request types across all '*.ds.impl.dart' files:"
echo "GET: $total_get"
echo "POST: $total_post"
echo "PUT: $total_put"
echo "DELETE: $total_delete"
