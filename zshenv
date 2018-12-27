export VISUAL=nvim
export EDITOR="$VISUAL"
alias vim=nvim
alias github='hub browse'
alias b='bundle exec'
alias ls='ls -G'
alias ag='ag -U'
alias space='echo "\n\n\n\n\n\n\n\n\n\n"'
alias tmux-project='tmux attach-session -t $(pwd | rev | cut -d '/' -f1 | rev) &>/dev/null || tmux start-server \; source-file .tmux.conf'

# The absence of this has been known to confuse Capistrano on other machines
export LC_ALL="en_US.UTF-8"
