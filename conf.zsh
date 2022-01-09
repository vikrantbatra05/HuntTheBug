#!/bin/zsh

target=$1

#Telegram Bot Config

telegram_token="#"
telegram_id="-#"
telegram_url="https://api.telegram.org/bot$telegram_token/sendDocument?chat_id=$telegram_id"
telegram_url_msg="https://api.telegram.org/bot$telegram_token/sendMessage"

#FindDomain Config SETTINGS

export findomain_virustotal_token='#'

export findomain_fb_token='#'

export findomain_securitytrails_token='#'

export findomain_spyse_token='#'

#GitHub SubDomain Token SETTINGS

github_token="#"

#Setup Dir

root_dir="/root/HuntTheBug"
hunt_dir="/root/HuntTheBug/SUB_HUNT"

mkdir -p "$hunt_dir/$target"
target_dir="$hunt_dir/$target"

mkdir -p "$target_dir/subs"
mkdir -p "$target_dir/live"
mkdir -p "$target_dir/recon"
mkdir -p "$target_dir/urls"
mkdir -p "$target_dir/dirs"
mkdir -p "$target_dir/ports"

subs_dir="$target_dir/subs"
live_dir="$target_dir/live"
recon_dir="$target_dir/recon"
urls_dir="$target_dir/urls"
dirs_dir="$target_dir/dirs"
ports_dir="$target_dir/ports"

###

wordlist_dir="$root_dir/wordlist"
config_dir="$root_dir/config"
wordlist="$wordlist_dir/all.txt"
resolver="$wordlist_dir/nameservers.txt"