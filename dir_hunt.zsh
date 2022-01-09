#!/bin/zsh

source conf.zsh

target=$1

echo "\n ===> DIR Bruteforce Start For $target \n"

#Start Messages

starttime=$(date)
curl -s -X POST $telegram_url_msg -d chat_id=$telegram_id -d text="DIR Bruteforce Start For $target @ $starttime"

#---->

python3 /root/tools/dirsearch/dirsearch.py -l $target_dir/live/live-host.txt -i 200,201,202,203,204,301,302,303,304 -b -o $dirs_dir/dir-search.html --format=html

 c_200_host=$(grep -c ".*" $dirs_dir/dir-search.html)
 msg_200_host="Dir BruteForce Complete  $target And We Found : $c_200_host"
 curl -s -X POST $telegram_url_msg -d chat_id=$telegram_id -d text="$msg_200_host"

 cp $dirs_dir/dir-search.html $target_dir/$target-dir-search.html
 curl -F document=@"$target_dir/$target-dir-search.html" $telegram_url

#---->

starttime=$(date)
curl -s -X POST $telegram_url_msg -d chat_id=$telegram_id -d text="DIR Bruteforce Finish For $target @ $starttime"

echo "\n ===> DIR Bruteforce Finish For $target \n"