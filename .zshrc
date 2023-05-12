
# https://volta.sh/
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# https://git-scm.com/book/ms/v2/Appendix-A%3A-Git-in-Other-Environments-Git-in-Zsh
autoload -Uz compinit && compinit

# setup prompt
eval "$(starship init zsh)"

# go
export GOPATH=$(go env GOPATH)
export PATH=$PATH:$GOPATH/bin

# alias
# https://github.com/sharkdp/bat
alias cat='bat -pP'