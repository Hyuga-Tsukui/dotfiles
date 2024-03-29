# setup zsh
# -----------------------------------------------------------------
setopt correct # コマンドのスペルミスのチェック
setopt correct_all # コマンドライン全てのスペルチェックをする
setopt hist_ignore_all_dups # 重複したコマンドはヒストリに追加しない
setopt hist_reduce_blanks # ヒストリ追加時に連続した空白は一つにする
setopt share_history # ホスト間でヒストリを共有する
setopt nolistbeep # ビープ音を鳴らさない
setopt auto_menu # 補完キー（Tab,  Ctrl+I) を連打するだけで順に補完候補を自動で補完する
setopt auto_param_slash # パラメータ展開時に末尾のスラッシュを自動で補完する
zstyle ':completion:*' list-colors di=34 fi=0 # 補完候補の色を設定


# https://volta.sh/
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# https://git-scm.com/book/ms/v2/Appendix-A%3A-Git-in-Other-Environments-Git-in-Zsh
autoload -Uz compinit && compinit

# https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

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
alias brdump='brew bundle dump --force --global' # brew installしたあとに実行すると、Brewfileを更新する

# setup zsh-completions
if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
    autoload -Uz compinit
    compinit
fi