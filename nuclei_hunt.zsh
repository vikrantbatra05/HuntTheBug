#!/bin/zsh

source conf.zsh

target=$1

echo "\n ===> Nuclei Hunt Start For $target \n"

#Start Messages

starttime=$(date)
curl -s -X POST $telegram_url_msg -d chat_id=$telegram_id -d text="Nuclei Hunt Start For $target @ $starttime"

#-->

cat $target_dir/live/live-host.txt | nuclei -c 500 -o $recon_dir/nuclei-full.txt -t /root/nuclei-templates/ -silent

cp $recon_dir/nuclei-full.txt $target_dir/$target-nuclei-result.txt

c_200_host=$(grep -c ".*" $target_dir/$target-nuclei-result.txt)
msg_200_host="Nuclei Complete : $c_200_host"
curl -s -X POST $telegram_url_msg -d chat_id=$telegram_id -d text="$msg_200_host"
curl -F document=@"$target_dir/$target-nuclei-result.txt" $telegram_url

#---->

starttime=$(date)
curl -s -X POST $telegram_url_msg -d chat_id=$telegram_id -d text="Nuclei Hunt Finish For $target @ $starttime"

echo "\n ===> Nuclei Hunt Complete For $target \n"