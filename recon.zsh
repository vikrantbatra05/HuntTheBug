#!/bin/zsh

target=$1

mkdir -p "/root/HuntTheBug/SUB_HUNT"

echo "\n ===> Recon Start For $target \n"

./sub_hunt.zsh $target

./sub_jack.zsh $target

./url_hunt.zsh $target

./dir_hunt.zsh $target

./port_hunt.zsh $target

./nuclei_hunt.zsh $target

echo "\n ===> Recon Complete For $target \n"