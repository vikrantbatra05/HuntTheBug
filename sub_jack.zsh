#!/bin/zsh

source conf.zsh

target=$1

echo "\n ===> Subdomain Takeover Start For $target \n"

#Start Messages

starttime=$(date)
curl -s -X POST $telegram_url_msg -d chat_id=$telegram_id -d text="Sub Domain Takeover Start For $target @ $starttime"

#-->

subjack -w $target_dir/subs/final.txt -t 100 -timeout 30 -o $recon_dir/$target-subjack.txt -ssl -c $root_dir/wordlist/fingerprints.json

 subjack_count=$(grep -c ".*" $recon_dir/$target-subjack.txt)
 msg_subjack_host="Subjack : $subjack_count"
 curl -s -X POST $telegram_url_msg -d chat_id=$telegram_id -d text="$msg_subjack_host"

cat $target_dir/live/live-host.txt | nuclei -c 500 -v -o $recrecon_diron/$target-nuclei-takeovers.txt -t /root/nuclei-templates/takeovers/

 nuclei_takeovers_count=$(grep -c ".*" $recrecon_diron/$target-nuclei-takeovers.txt)
 msg_nuclei_takeovers_host="Nuclei Takeovers : $nuclei_takeovers_count"
 curl -s -X POST $telegram_url_msg -d chat_id=$telegram_id -d text="$msg_nuclei_takeovers_host"

 curl -F document=@"$recon_dir/$target-subjack.txt" $telegram_url
 curl -F document=@"$recrecon_diron/$target-nuclei-takeovers.txt" $telegram_url

#---->

starttime=$(date)
curl -s -X POST $telegram_url_msg -d chat_id=$telegram_id -d text="Sub Domain Takeover Finish For $target @ $starttime"

echo "\n ===> Subdomain Takeover Complete For $target \n"