#!/bin/bash

# ---------------- miscellaneous  ---------------
export EDITOR="nvim"
export PAGER="less"
export MANPAGER='nvim +Man!'
eval "$(dircolors -b "$HOME/dotfiles/dircolors")"

# ------------------- options  ------------------
shopt -s checkwinsize

# -------------------  clean ~ ------------------
 
export CARGO_HOME="$XDG_DATA_HOME"/cargo 
export LESSHISTFILE=-

# ------------------- history -------------------

HISTSIZE=1048576
HISTFILESIZE=$HISTSIZE

#Check if history file exists
HISTFILE=$XDG_STATE_HOME/bash/history
if [ ! -f "$HISTFILE" ]; then
  mkdir -p "$(dirname "$HISTFILE")"
  touch "$HISTFILE"
fi

HISTCONTROL=ignoreboth:erasedups
shopt -s histappend

# ------------------- fzf -----------------------

export FZF_DEFAULT_OPTS="
  --color hl:#F27900,hl+:#F27900,fg+:-1,bg+:-1,border:#1A1918 
  --layout=reverse
  --prompt='$ '
  --pointer='▶'
  --marker='│'
  --height=10
  --ansi
  --tmux
  --style=minimal
  --border=sharp
  --info=inline-right
"
eval "$(fzf --bash)"
export FZF_CTRL_T_COMMAND="fd --color=always"
export FZF_CTRL_T_OPTS=""

# ------------------ functions ------------------

function ff(){
  fd_cmd="fd --follow --color always"
  selected=$($fd_cmd | fzf-tmux \
  --bind "ctrl-d:reload($fd_cmd --type dir)" \
  --bind "ctrl-h:reload($fd_cmd --hidden)" \
  --bind "ctrl-o:reload($fd_cmd)" \
  -p 50%,30% --ansi)

  [[ ! -z "$selected" ]] || return
  if [[ -d "$selected" ]]; then
    cd "$selected"; return || return
  else    
    cd $(dirname "$selected") || return
  fi

  file=$(basename "$selected")
  filetype=$(file --mime-type -b "$file")

  case $filetype in
    text/* | application/* | inode/x-empty) $EDITOR "$file";;
    *) xdg-open "$file";;
  esac

}
bind '"\C-f":"\C-uff\n"'

function mcdir() {
  mkdir "$1"
  cd "$1" || return
}


# ------------------ aliases ------------------

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ls='ls -hF --color=auto --group-directories-first'
alias l='ls -lahF --color=auto --group-directories-first'
alias c='clear'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -ir'
alias b='cd - >/dev/null'
alias tam='tmux attach -t main'
alias tnm='tmux new -s main'
alias week='date +%V'
alias py='python'
alias o='xdg-open'

# ------------------- prompt -------------------

PROMPT_DIRTRIM=3

# Get current branch in git repo
function git_branch(){
  git branch 2>/dev/null | grep '^*' | sed 's/*//'
}

function git_dirty(){
  [[ -z $(git status -s 2>/dev/null) ]] || echo '?'
}

# Define the color codes for bold text and blue color
RESET='\[\033[0m\]'
PURPLE='\[\033[35m\]'
BLUE='\[\033[34m\]'

# Update the PS1 variable with bold formatting
PS1="\n┌─[${BLUE}\w${RESET}]${PURPLE}\$(git_branch)\$(git_dirty)${RESET}\n└─$ "
