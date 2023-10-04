#!/usr/bin/env bash
#
# @(#) v0.3.0 2023-10-05T05:49:45+09:00
# @(#) Copyright (C) 2023 hituzi-no-sippo
# @(#) LICENSE: MIT-0 (https://choosealicense.com/licenses/mit-0/)

err() {
  printf '[%s]: %s\n' "$(date +'%Y-%m-%dT%H:%M:%S%z')" "$*" >&2
}

info() {
  printf "\n%s\n" "$*"
}

install_tools_with_version_manager() {
  info 'Will install tools with aqua.'

  if ! aqua install --only-link; then
    err 'Failed tool install with aqua.'

    return 1
  fi

  info 'Successful lazy install. Download a tool when that is executed.'
}
install_ruby_gems() {
  info 'Will install Ruby gems.'

  if ! bundle install; then
    err 'Failed gems install with bundler.'

    return 1
  fi

  info 'Successful install Ruby gems.'
}
setup_git_hook() {
  info "Setup Git hooks"

  if ! lefthook install --aggressive; then
    err 'Failed Git hooks setup.'

    return 1
  fi

  info 'Successful install Git hooks.'
}

main() {
  info 'Setup Start'

  install_tools_with_version_manager

  install_ruby_gems

  setup_git_hook

  info 'Setup End'
}

main
