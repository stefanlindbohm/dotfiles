HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

# {{{ Highlighting
if [[ -f /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
  source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

  typeset -A ZSH_HIGHLIGHT_STYLES
  ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red,bold'
  ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=magenta'
  ZSH_HIGHLIGHT_STYLES[alias]='underline'
  ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=green,underline'
  ZSH_HIGHLIGHT_STYLES[builtin]='none'
  ZSH_HIGHLIGHT_STYLES[function]='none'
  ZSH_HIGHLIGHT_STYLES[command]='none'
  ZSH_HIGHLIGHT_STYLES[precommand]='fg=green,underline'
  ZSH_HIGHLIGHT_STYLES[commandseparator]='none'
  ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=green'
  ZSH_HIGHLIGHT_STYLES[path]='underline'
  ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=yellow,underline'
  ZSH_HIGHLIGHT_STYLES[globbing]='fg=blue'
  ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=blue'
  ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='none'
  ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='none'
  ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='none'
  ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=yellow'
  ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=yellow'
  ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=yellow'
  ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=cyan'
  ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='fg=cyan'
  ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]='fg=cyan'
  ZSH_HIGHLIGHT_STYLES[assign]='none'
  ZSH_HIGHLIGHT_STYLES[redirection]='fg=magenta'
  ZSH_HIGHLIGHT_STYLES[comment]='fg=white'
  ZSH_HIGHLIGHT_STYLES[default]='none'
fi
# }}}
# {{{ ZLE
bindkey -v

# Outputs $1 when on insert mode and outputs $2 when on command mode.
# zle_mode_output "when insert" "when command"
function zle_mode_output {
  # Keymap could be empty sometimes; assume insert mode
  case $KEYMAP in
    ("vicmd") echo $2;;
    (*) echo $1
  esac
}

# Reset prompt on mode change
function zle-keymap-select {
  zle reset-prompt
}
zle -N zle-keymap-select

autoload edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# }}}
# {{{ Color shortcuts and magic
autoload colors
colors

function is256color() {
  if [[ $TERM == *256* ]]; then
    return true
  else
    return false
  fi
}
# }}}
# {{{ Named Directories
# Make certain paths into named directories ("~name" instead of "/path/to/name")

# namedir name [path]
namedir () {
  local target
  if [[ $2 == "" ]]; then
    target="$(pwd)"
  else
    target=$2
  fi

  hash -d "$1"="$target"
}

# Give all projects a name
if [ -d ~/Code ]; then
  for dir in ~/Code/*(/N); do
    namedir "$(basename $dir)" "$dir"
  done
fi

# }}}
# {{{ Completions

autoload -Uz compinit
compinit

# Homebrew puts a lot of completions in here
if [ -d /usr/local/share/zsh/site-functions ]; then
  fpath=(/usr/local/share/zsh/site-functions $fpath)
fi

# }}}
# {{{ Prompt

setopt prompt_subst
setopt transient_rprompt

function {
  autoload -Uz vcs_info
  zstyle ':vcs_info:*' enable git
  zstyle ':vcs_info:*' check-for-changes true

  zstyle ':vcs_info:*' stagedstr "%F{green}S"
  zstyle ':vcs_info:*' unstagedstr "%F{red}U"

  local branch_format="%F{yellow}%b"
  zstyle ':vcs_info:*' formats       "%c%u ${branch_format}%f" ""
  zstyle ':vcs_info:*' actionformats "%c%u ${branch_format}%f (%F{cyan}%a%f)" ""
}

precmd() {
  vcs_info
}

# Show mode information by the last character in the prompt
function prompt_end_character {
  zle_mode_output "$" "%F{red}>%f"
}

function {
  # Color user differently if we have a privileged user ("!")
  local user="%(!.%F{red}.%F{green})%n"

  if [[ -n $SSH_CLIENT ]]; then
    if is256color; then
      local host='%F{white}@%F{242}%4m'
    else
      local host='%f@%F{blue}%4m'
    fi
  else
    local host=''
  fi

  if is256color; then
    local current_time="%F{white}%D{%H:%M}%F{242}%D{:%S}"
  else
    local current_time="%F{white}%D{%H:%M}"
  fi

  local last_status="%(?.. %F{red}*%?)"
  local dir="%B%F{blue}%4~%b"
  local current_jobs="%(1j.%F{magenta}%BJ%j%b .)"
  local end='$(prompt_end_character)%f%k%b'

  export RPROMPT='$vcs_info_msg_0_'
  export PROMPT="${user}${host} ${current_time}${last_status} $dir ${current_jobs}${end} "
}

# }}}

# These should be in .zshenv, but some initialization required for rbenv happens after that
eval "$(rbenv init - zsh)"
export PATH=".git/safe/../../bin:$HOME/Scripts:$PATH"
