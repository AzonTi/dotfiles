GROUP_LIST="base-devel xfce4 fcitx-im texlive-most"
alias package-list="comm -23 <((yay -Qqe; echo ${GROUP_LIST} | tr ' ' '\n') | sort) <(yay -Qqg ${GROUP_LIST} | sort)"
