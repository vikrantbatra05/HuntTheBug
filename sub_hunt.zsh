#!/bin/zsh

source conf.zsh

target=$1

echo "\n ===> Subdomain Hunting Start For $target \n"

#Start Messages

start_message(){
starttime=$(date)
curl -s -X POST $telegram_url_msg -d chat_id=$telegram_id -d text="Sub Domain Enum Start For $target @ $starttime"
}

#SubDomain Enumation Start

sub_enum(){

#01 - AMASS

amass_enum(){
  amass enum  --passive -d $target -config $config_dir/amass-config.ini -o $subs_dir/amass.txt
  ct=$(grep -c ".*" $subs_dir/amass.txt)
  mt="Amass : $ct"
  curl -s -X POST $telegram_url_msg -d chat_id=$telegram_id -d text="$mt"
}

#02 - SubFinder

subfinder_enum(){
  subfinder -d $target -o $subs_dir/subfinder.txt -config $config_dir/subfinder-config.yaml
  ct=$(grep -c ".*" $subs_dir/subfinder.txt)
  mt="Subfinder : $ct"
  curl -s -X POST $telegram_url_msg -d chat_id=$telegram_id -d text="$mt"
}

#03 - SubLis3R

sublist3r_enum(){
 sublist3r -v -d $target -o $subs_dir/sublist3r.txt
 sed -i 's/<BR>/\n/g' $subs_dir/sublist3r.txt
 sort $subs_dir/sublist3r.txt | uniq > $subs_dir/sublist3r-fl.txt
 rm $subs_dir/sublist3r.txt
 mv $subs_dir/sublist3r-fl.txt $subs_dir/sublist3r.txt
 ct=$(grep -c ".*" $subs_dir/sublist3r.txt)
 mt="SubLis3R : $ct"
 curl -s -X POST $telegram_url_msg -d chat_id=$telegram_id -d text="$mt"
}

#4 - Crobat

crobat_enum(){
 crobat -s $target > $subs_dir/crobat.txt
 ct=$(grep -c ".*" $subs_dir/crobat.txt)
 mt="Crobat : $ct"
 curl -s -X POST $telegram_url_msg -d chat_id=$telegram_id -d text="$mt"
}

#5 - AsseFinder

assetfinder_enum(){
 assetfinder -subs-only $target > $subs_dir/assetfinder.txt
 ct=$(grep -c ".*" $subs_dir/assetfinder.txt)
 mt="AsseFinder : $ct"
 curl -s -X POST $telegram_url_msg -d chat_id=$telegram_id -d text="$mt"
}

#6 - Find Domain

findomain_enum(){
 findomain -u $subs_dir/findomain.txt -t $target
 ct=$(grep -c ".*" $subs_dir/findomain.txt)
 mt="Find Domain : $ct"
 curl -s -X POST $telegram_url_msg -d chat_id=$telegram_id -d text="$mt"
}

#7 - GitHub SubDomain

github-subdomains_enum(){
 github-subdomains -d $target -t $github_token -o $subs_dir/github-subdomains.txt -raw
 ct=$(grep -c ".*" $subs_dir/github-subdomains.txt)
 mt="GitHub SubDomain : $ct"
 curl -s -X POST $telegram_url_msg -d chat_id=$telegram_id -d text="$mt"
}

#8 - Subscraper

subscraper_enum(){
 subscraper $target -o $subs_dir/subscraper.txt
 ct=$(grep -c ".*" $subs_dir/subscraper.txt)
 mt="Subscraper : $ct"
 curl -s -X POST $telegram_url_msg -d chat_id=$telegram_id -d text="$mt" 
}

#0 - Mix All

mix_subs(){

 sort -u $subs_dir/* > $subs_dir/final.txt
 awk '{gsub("*.", "");print}' $subs_dir/final.txt > $subs_dir/fl-1.txt
 awk '{gsub("www.", "");print}' $subs_dir/fl-1.txt > $subs_dir/fl-2.txt
 awk '{print tolower($0)}' $subs_dir/fl-2.txt > $subs_dir/fl-3.txt
 rm $subs_dir/final.txt $subs_dir/fl-1.txt $subs_dir/fl-2.txt
 mv $subs_dir/fl-3.txt $subs_dir/final-1.txt
 sort -u $subs_dir/final-1.txt > $subs_dir/final.txt
 rm $subs_dir/final-1.txt

 mix_subs=$(grep -c ".*" $subs_dir/final.txt)

 msg_subs="Sub Domain Scan Complete  $domain And We Found : $mix_subs Sub Domains"

 curl -s -X POST $telegram_url_msg -d chat_id=$telegram_id -d text="$msg_subs"

 cp $subs_dir/final.txt $target_dir/$target-all-sub-domains.txt

 curl -F document=@"$target_dir/$target-all-sub-domains.txt" $telegram_url

}

amass_enum
subfinder_enum
sublist3r_enum
crobat_enum
assetfinder_enum
findomain_enum
github-subdomains_enum
subscraper_enum
mix_subs

}

#Live Domain Test

live_domain(){

 httpx -l $subs_dir/final.txt  -nc -sc -td -server -title -ip -cdn -vhost -o $live_dir/httpx.txt

 httpx_host=$(grep -c ".*" $live_dir/httpx.txt)
 msg_httpx_host="HTTPX : $httpx_host"
 curl -s -X POST $telegram_url_msg -d chat_id=$telegram_id -d text="$msg_httpx_host"

 cat $live_dir/httpx.txt | grep -Eo "(http|https)://[a-zA-Z0-9./?=_%:-]*" > $live_dir/live_host.txt

 cat $live_dir/httpx.txt | grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | sort -u > $live_dir/live_ip.txt

 cat $subs_dir/final.txt | httprobe > $live_dir/httprobe.txt

 httprobe=$(grep -c ".*" $live_dir/httprobe.txt)
 msg_httprobe_host="HTTPROBE : $httpx_host"
 curl -s -X POST $telegram_url_msg -d chat_id=$telegram_id -d text="$msg_httprobe_host"

 sort -u $live_dir/live_host.txt $live_dir/httprobe.txt > $live_dir/live-host.txt

 awk '{print tolower($0)}' $live_dir/live-host.txt > $live_dir/live-host-1.txt

 sort -u $live_dir/live-host-1.txt > $live_dir/live-host.txt

 cat $live_dir/live-host.txt | hakcheckurl | sort -u > $live_dir/live-with-status-code.txt

 cat $live_dir/live-host.txt | hakcheckurl | grep 403 > $live_dir/403-url.txt
 cat $live_dir/live-host.txt | hakcheckurl | grep 200 > $live_dir/200-url.txt

 rm $live_dir/live-host-1.txt

 live_host=$(grep -c ".*" $live_dir/live-host.txt)
 msg_live_host="Live Scan Complete  $target And We Found : $live_host Sub Domains"
 curl -s -X POST $telegram_url_msg -d chat_id=$telegram_id -d text="$msg_live_host"

 cp $live_dir/live-host.txt $target_dir/$target-live-host.txt
 cp $live_dir/live-with-status-code.txt $target_dir/$target-live-with-status-code.txt
 cp $live_dir/403-url.txt $target_dir/$target-403-url.txt
 cp $live_dir/200-url.txt $target_dir/$target-200-url.txt

 curl -F document=@"$target_dir/$target-live-host.txt" $telegram_url
 curl -F document=@"$target_dir/$target-live-with-status-code.txt" $telegram_url
 curl -F document=@"$target_dir/$target-403-url.txt" $telegram_url 
 curl -F document=@"$target_dir/$target-200-url.txt" $telegram_url

}

#End Message

recon_complete(){
endtime=$(date)
curl -s -X POST $telegram_url_msg -d chat_id=$telegram_id -d text="Subdomain Hunting For $target is Finish @ $endtime. Good Bye"
}

#Functions Start

start_message
sub_enum
live_domain
recon_complete

echo "\n\n ====> Subdomain Hunting Comlete For $target \n"