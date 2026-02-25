# Slugify plugin for Zsh

# Slugify a string or file name to a URL-friendly format.
function slugify() {
  local input
  local separator
  local keep_case
  separator="${SLUGIFY_SEPARATOR:--}"
  keep_case="${SLUGIFY_KEEP_CASE:-0}"

  if [[ $# -gt 0 ]]; then
    input="$*"
  elif [[ -p /dev/stdin ]]; then
    input=$(cat)
  else
    input=""
  fi

  local normalized
  if [[ "$keep_case" == "1" || "$keep_case" == "true" ]]; then
    normalized=$(echo "$input" \
    | iconv -t ascii//TRANSLIT 2>/dev/null \
    | sed -E 's/[^A-Za-z0-9_-]+/ /g; s/^ +| +$//g')
  else
    normalized=$(echo "$input" \
    | iconv -t ascii//TRANSLIT 2>/dev/null \
    | tr '[:upper:]' '[:lower:]' \
    | sed -E 's/[^a-z0-9_-]+/ /g; s/^ +| +$//g')
  fi

  echo "${normalized// /$separator}"
}

# Slugify a file name and rename the file.
function slugify-file() {
  local file="$1"
  if [[ -f "$file" ]]; then
    local dir
    dir=$(dirname "$file")
    local base
    base=$(basename "$file")
    local name
    local ext

    if [[ "$base" == .* && "$base" != *.*.* ]]; then
      # Hidden file without extension (e.g., .gitignore)
      name="$base"
      ext=""
    elif [[ "$base" == *.* ]]; then
      # Regular file with extension (e.g., my file.txt)
      name="${base%.*}"
      ext=".${base##*.}"
    else
      # Regular file without extension (e.g., README)
      name="$base"
      ext=""
    fi

    local slugified
    slugified=$(slugify "$name")
    local target
    target="$dir/$slugified$ext"

    if [[ "$file" != "$target" ]]; then
      mv "$file" "$target"
    fi
  else
    echo "File not found: $file" >&2
  fi
}

# Slugify all file names in a directory (not recursive).
function slugify-dir() {
  local dir="$1"
  if [[ -d "$dir" ]]; then
    find "$dir" -maxdepth 1 -type f -print0 | while IFS= read -r -d '' file; do
      slugify-file "$file"
    done
  else
    echo "Directory not found: $dir" >&2
  fi
}

# Aliases for convenience
alias slugifyf='slugify-file'
alias slugifyd='slugify-dir'
