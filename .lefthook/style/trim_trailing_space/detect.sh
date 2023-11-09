#!/usr/bin/env bash
#
# @(#) v0.1.0 2023-11-09T07:45:45+0900
# @(#) Copyright (C) 2023 hituzi no sippo
# @(#) LICENSE: MIT-0 (https://choosealicense.com/licenses/mit-0/)

detect_trailing_white_space() {
  printf '%s' "$@" |
    xargs \
      grep \
      --line-number \
      --regexp='[[:blank:]]\+$'
}

main() {
  # References
  # - https://www.shellcheck.net/wiki/SC1091
  # - https://github.com/koalaman/shellcheck/wiki/directive#source
  # shellcheck source=SCRIPTDIR/../../scripts/exclude_binary_file.sh
  . "$(git rev-parse --show-toplevel)/.lefthook/scripts/exclude_binary_file.sh"

  files=$(exclude_binary_file "$@")

  if [ $? -eq 2 ]; then
    exit 2
  fi

  if [ "$files" = '' ]; then
    exit 0
  fi

  detect_trailing_white_space "$files"

  # if any invocation of the command exited with status 1-125,
  # xagrs exits with status 123.
  test $? -eq 123
}

main "$@"
