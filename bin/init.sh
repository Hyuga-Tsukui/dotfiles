#!/bin/bash

# Helpers
# @see https://github.com/mistymagich/dotfiles/blob/9174175f27b3be3daa7ff825dab96a6eb6ca5216/setup.sh#LL26C1-L28C2

section() {
   echo -e "\n$(tput setaf 5)###$(tput op) $1"
}

if [ "$(uname)" != "Darwin" ] ; then
	echo "Not macOS!"
	exit 1
fi

# Install xcode
# -----------------------------------------------------------------
section "Install xcode"
if [ ! -x "$(command -v xcode-select)" ] ; then
	xcode-select --install > /dev/null
else
	echo "xcode-select already installed"
fi

# Install brew
# -----------------------------------------------------------------
section "Install brew"
if [ ! -x "$(command -v brew)" ] ; then
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" > /dev/null
else
	echo "brew already installed"
fi

# Configuration Git
# @see [.gitconfigはGitで管理しておいて、git config user.name/user.emailは管理したくない](https://mistymagich.wordpress.com/2016/08/31/gitconfig%E3%81%AFgit%E3%81%A7%E7%AE%A1%E7%90%86%E3%81%97%E3%81%A6%E3%81%8A%E3%81%84%E3%81%A6%E3%80%81git-config-user-nameuser-email%E3%81%AF%E7%AE%A1%E7%90%86%E3%81%97%E3%81%9F%E3%81%8F%E3%81%AA/)
# -----------------------------------------------------------------
section "Configuration Git"
GIT_CONFIG_LOCAL=~/.gitconfig.local
if [ ! -e $GIT_CONFIG_LOCAL ]; then
	echo -n "git config user.email?> "
	read -r GIT_AUTHOR_EMAIL

	echo -n "git config user.name?> "
	read -r GIT_AUTHOR_NAME

	cat << EOF > $GIT_CONFIG_LOCAL
[user]
    name = $GIT_AUTHOR_NAME
    email = $GIT_AUTHOR_EMAIL
EOF
fi