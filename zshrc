# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

if [[ -f /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
  source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

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

  local branch_format="%F{202}%r%f:%F{214}%b%f"
  local changes_format="%F{022}%c%F{088}%u"
  zstyle ':vcs_info:*' formats       "${changes_format} ${branch_format}%f" ""
  zstyle ':vcs_info:*' actionformats "${changes_format} ${branch_format}%f [%F{cyan}%a%f]" ""
}

precmd() {
  vcs_info
}

reset-prompt-accept-line() {
  zle reset-prompt
  zle accept-line
}

zle -N reset-prompt-accept-line
bindkey "^M" reset-prompt-accept-line

# Show mode information by the last character in the prompt
function prompt_end_character {
  zle_mode_output "$" "%F{196}>%f"
}

function {
  if is256color; then
    local current_time="%F{247}%D{%H:%M}%F{240}%D{:%S}"
  else
    local current_time="%F{white}%D{%H:%M}%B%F{black}%D{:%S}%b"
  fi

  if [[ -n $SSH_CLIENT ]]; then
    if is256color; then
      local host='%F{241}@%F{60}%4m'
    else
      local host='%f@%F{blue}%4m'
    fi
  else
    local host=''
  fi

  # Color user differently if we have a privileged user ("!")
  local user="%(!.%F{196}.%F{072})%n"

  local dir="%B%F{blue}%4~%b"
  local last_status="%(?.. %F{red}*%?)"
  local current_jobs="%(1j.%F{magenta}%BJ%j%b .)"
  local end='$(prompt_end_character)%f%k%b'

  export RPROMPT='$vcs_info_msg_0_'
  export PROMPT="${user}${host} ${current_time}${last_status} $dir ${current_jobs}${end} "
}

# }}}

export PATH="~/.rbenv/bin:/usr/local/bin:/usr/local/sbin:$PATH:~/Scripts:~/Code/hemnet-terminal-command/bin"
alias git=hub
alias github='hub browse'
alias b='bundle exec'
alias ls='ls -G'
alias space='echo "\n\n\n\n\n\n\n\n\n\n"'
eval "$(rbenv init - zsh)"

# The absence of this has been known to confuse Capistrano on other machines
export LC_ALL="en_US.UTF-8"
