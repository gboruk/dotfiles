alias gs='git status'
alias ll='ls -lah'
alias reload='source ~/.zshrc'

mkcd() {
  mkdir -p "$1" && cd "$1"
}

# cdd: jump to $DEV_DIR, or glob into a matching subproject (cdd <name>)
cdd() {
  if [ -z "$1" ]; then
    cd "$DEV_DIR"
    return
  fi
  local match=("$DEV_DIR"/*/"$1"(N))
  if [ ${#match[@]} -gt 0 ]; then
    cd "${match[1]}"
  else
    cd "$DEV_DIR/$1"
  fi
}
