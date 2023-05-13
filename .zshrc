# zsh opt
# -----------------------------------------------------------------
setopt correct # コマンドのスペルミスのチェック
setopt hist_ignore_all_dups # 重複したコマンドはヒストリに追加しない
setopt hist_reduce_blanks # ヒストリ追加時に連続した空白は一つにする
setopt share_history # ホスト間でヒストリを共有する


# https://volta.sh/
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# https://git-scm.com/book/ms/v2/Appendix-A%3A-Git-in-Other-Environments-Git-in-Zsh
autoload -Uz compinit && compinit

# setup starship
# -----------------------------------------------------------------
eval "$(starship init zsh)"

# go
export GOPATH=$(go env GOPATH)
export PATH=$PATH:$GOPATH/bin

# alias
# -----------------------------------------------------------------
# https://github.com/sharkdp/bat
alias cat='bat -pP'
alias brdump='brew bundle dump --force' # brew installしたあとに実行すると、Brewfileを更新する

# setup zsh-completions
if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
    autoload -Uz compinit
    compinit
fi