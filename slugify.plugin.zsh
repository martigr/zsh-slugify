function slugify() {
  local input
  if [[ -p /dev/stdin ]]; then
    input=$(cat)
  else
    input="$*"
  fi

  echo "$input" \
  | iconv -t ascii//TRANSLIT 2>/dev/null \
  | tr '[:upper:]' '[:lower:]' \
  | sed -E 's/[^a-z0-9]+/-/g; s/^-+|-+$//g'
}
