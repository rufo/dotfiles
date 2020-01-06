#!/bin/bash

function yes_or_no {
    while true; do
        read -rp "$* [y/n]: " yn
        case $yn in
            [Yy]*) return 0  ;;  
            [Nn]*) echo "skipped" ; return  1 ;;
        esac
    done
}

if yes_or_no "set up homebrew zsh?"; then
	HOMEBREW_ZSH="/usr/local/bin/zsh"

	if [ -f $HOMEBREW_ZSH ]; then
		if grep -Fxq "$HOMEBREW_ZSH" /etc/shells; then
			echo "homebrew zsh in allowed shells, skipping"
		else
			echo "installing homebrew zsh to allowed shells"
			sudo sh -c "echo \"$HOMEBREW_ZSH\" >> /etc/shells"
		fi

		echo "setting default shell to homebrew zsh"
		chsh -s /usr/local/bin/zsh
	fi
fi

if yes_or_no "set up git persona?"; then
    git config --global user.name "Rufo Sanchez"
    git config --global user.email "rufo@rufosanchez.com"
fi
