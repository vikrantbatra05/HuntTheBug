#!/bin/zsh

source conf.zsh

#Setup Dir

target=$1

echo "\n ===> Port Hunting Start For $target \n"

#Start Messages

starttime=$(date)
curl -s -X POST $telegram_url_msg -d chat_id=$telegram_id -d text="Port Hunting Start For $target @ $starttime"

#-->

parallel -j100 --retries 3 dig +short :::: $target_dir/subs/final.txt | grep -E '^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' > $ports_dir/ip.txt

cat $target_dir/live/live_ip.txt >> $ports_dir/ip.txt

sort -u $ports_dir/ip.txt > $ports_dir/ip_list.txt

naabu -l $ports_dir/ip_list.txt -top-ports 1000 -o $ports_dir/naabu_ip.txt

naabu -l $target_dir/subs/final.txt -top-ports 1000 -o $ports_dir/naabu_sub.txt

 cp $ports_dir/naabu_ip.txt $target_dir/$target-naabu_ip.txt
 curl -F document=@"$target_dir/$target-naabu_ip.txt" $telegram_url

 cp $ports_dir/naabu_sub.txt $target_dir/$target-naabu_sub.txt
 curl -F document=@"$target_dir/$target-naabu_sub.txt" $telegram_url

#---->

starttime=$(date)
curl -s -X POST $telegram_url_msg -d chat_id=$telegram_id -d text="Port Hunting Finish For $target @ $starttime"

echo "\n ===> Port Hunting Finish For $target \n"