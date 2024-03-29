#!/usr/bin/env bash
#
# @(#) v0.4.0 2023-09-02T17:48:15+09:00
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
install_node_packages_with_npm() {
  info 'Will install Node packages with npm.'

  if ! npm install; then
    err 'Failed Node packages install with npm.'

    return 1
  fi

  info 'Successful install Node packages.'
}
install_ruby_gems() {
  info 'Will install Ruby gems.'

  if ! bundle install; then
    err 'Failed gems install with bundler.'

    return 1
  fi

  info 'Successful install Ruby gems.'
}
setup_natural_language() {
  info 'Setup Natural Language tools.'

  _setup_linter() {
    vale sync
  }

  if ! _setup_linter; then
    err 'Failed Natural Language tools setup.'

    return 1
  fi

  info 'Successful install Natural Language tools.'
}
setup_git_hook() {
  info "Setup Git hooks"

  if ! lefthook install --force; then
    err 'Failed Git hooks setup.'

    return 1
  fi

  info 'Successful install Git hooks.'
}

main() {
  info 'Setup Start'

  funcs=(
    'install_tools_with_version_manager'
    'install_node_packages_with_npm'
    'install_ruby_gems'
    'setup_natural_language'
    'setup_git_hook'
  )

  for func in "${funcs[@]}"; do
    if ! "$func"; then
      err 'Failed setup.'

      return 1
    fi
  done

  info 'Successful setup'
}

main
