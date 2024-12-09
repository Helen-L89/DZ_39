#!/bin/bash

while [[ $# -gt 0 ]]; do
  case "$1" in
    --file)
      files+=("$2")
      shift 2
      ;;
    --extension)
      extension="$2"
      shift 2
      ;;
    --replacement)
      replacement="$2"
      shift 2
      ;;
    *)
      echo "Unknown argument: $1"
      exit 1
      ;;
  esac
done

if [[ -z "$extension" || -z "$replacement" ]]; then
  echo "Both --extension and --replacement must be specified."
  exit 1
fi

for file in "${files[@]}"; do
  if [[ "$file" == *.$extension ]]; then
    new_file="${file%.$extension}.$replacement"
    mv "$file" "$new_file" 2>/dev/null
    if [[ $? -eq 0 ]]; then
      echo "$(realpath "$new_file")"
    else
      echo "Failed to rename $file"
    fi
  fi
done
