export VISUAL=nvim
export EDITOR="$VISUAL"
alias vim=nvim
alias b='bundle exec'
alias ls='ls -G'
alias ag='ag -U'
alias tmux-project='tmux attach-session -t $(pwd | rev | cut -d '/' -f1 | rev) &>/dev/null || tmux start-server \; source-file .tmux.conf'

export PATH=".git/safe/../../bin:$HOME/Scripts:$PATH"
