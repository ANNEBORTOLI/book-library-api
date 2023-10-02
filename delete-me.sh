#!/bin/bash
# md-toc.sh
############
# Generates a Table of Contents getting a markdown file as input.
#
# Inspiration for this script:
# https://medium.com/@acrodriguez/one-liner-to-generate-a-markdown-toc-f5292112fd14
#
# The list of invalid chars is probably incomplete, but is good enough for my
# current needs.
# Got the list from:
# https://github.com/thlorenz/anchor-markdown-header/blob/56f77a232ab1915106ad1746b99333bf83ee32a2/anchor-markdown-header.js#L25


# needed for elementInArray()
shopt -s extglob


joinBy() {
  local IFS="$1"
  echo "${*:2}"
}


elementInArray() {
  local element="$1"
  local array=("${@:2}")
  [[ "$element" == @($(joinBy '|' "${array[@]//|/\\|}")) ]]
}


toc() {
  local invalidChars="'[]/?!:\`.,()*\";{}+=<>~$|#@&–—"
  local inputFile="$1"

  [[ -f "${inputFile}" ]] || return 1

  local line
  local level
  local title
  local anchor
  local anchorList=()
  local i

  while IFS='' read -r line || [[ -n "${line}" ]]; do
    level="$(echo "${line}" | sed -E 's/^#(#+).*/\1/; s/#/    /g; s/^    //')"
    title="$(echo "${line}" | sed -E 's/^#+ //')"
    anchor="$(echo "${title}" | tr '[:upper:] ' '[:lower:]-' | tr -d "$invalidChars")"

    if elementInArray "${anchor}" "${anchorList[@]}"; then
      # limitation: allows only 100 repeated anchors
      for i in {1..100}; do
        elementInArray "${anchor}-${i}" "${anchorList[@]}" && continue
        anchor="${anchor}-${i}"
        break
      done
    fi

    echo "${level}- [${title}](#${anchor})"
    anchorList+=("${anchor}")
  done <<< "$(grep -E '^#{2,10} ' "${inputFile}" | tr -d '\r')"
}

main() {
    toc "$@"
}

[[ "$0" == "$BASH_SOURCE" ]] && main "$@"
