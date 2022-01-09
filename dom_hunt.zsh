#!/bin/zsh

domain=$1

echo "\n ===> Domain Hunting Start For $domain \n"

#Telegram Bot Config

telegram_token="#"
telegram_id="#"
telegram_url="https://api.telegram.org/bot$telegram_token/sendDocument?chat_id=$telegram_id"
telegram_url_msg="https://api.telegram.org/bot$telegram_token/sendMessage"

#Setup Dir

root_dir="/root/HuntTheBug"
mkdir -p "/root/HuntTheBug/DOM_HUNT"
dom_dir="$root_dir/DOM_HUNT"

mkdir -p $dom_dir/$domain
domain_dir="$dom_dir/$domain"

wordlist="$root_dir/wordlist/raft-small-files.txt"

#Start Messages

start_message(){
starttime=$(date)
curl -s -X POST $telegram_url_msg -d chat_id=$telegram_id -d text="Domain Hunting Start For $domain @ $starttime"
}

wayback_check(){

raw_urls(){

echo $domain | gau > $domain_dir/gau-url.txt
echo $domain | waybackurls > $domain_dir/wayback-urls.txt

sort -u $domain_dir/gau-url.txt $domain_dir/wayback-urls.txt > $domain_dir/final-url.txt

rm $domain_dir/gau-url.txt $domain_dir/wayback-urls.txt

cat $domain_dir/final-url.txt | egrep -v "\.woff|\.ttf|\.svg|\.eot|\.png|\.jpeg|\.jpg|\.svg|\.css|\.ico|\.js|\.gif|\.webp|\.JPG|\.PNG|\.CSS|\.JS|\.WEBP|\.GIF|\.Jpg|\.JPEG" > $domain_dir/clean-urls.txt

ffuf -c -u "FUZZ" -w $domain_dir/clean-urls.txt -mc 200 -of csv -t 100 -o $domain_dir/tmp.txt

cat $domain_dir/tmp.txt | grep http | awk -F "," '{print $1}' > $domain_dir/live-urls.txt

mv $domain_dir/tmp.txt $domain_dir/live_url.csv

}

gf_urls(){

mkdir -p $domain_dir/gf

gf idor $domain_dir/final-url.txt > $domain_dir/gf/gf-idor.txt
gf img-traversal $domain_dir/final-url.txt > $domain_dir/gf/gf-img-traversal.txt
gf interestingEXT $domain_dir/final-url.txt > $domain_dir/gf/gf-interestingEXT.txt
gf interestingparams $domain_dir/final-url.txt > $domain_dir/gf/gf-interestingparams.txt
gf interestingsubs $domain_dir/final-url.txt > $domain_dir/gf/gf-interestingsubs.txt
gf ip $domain_dir/final-url.txt > $domain_dir/gf/gf-ip.txt
gf jwt $domain_dir/final-url.txt > $domain_dir/gf/gf-jwt.txt
gf lfi $domain_dir/final-url.txt > $domain_dir/gf/gf-lfi.txt
gf php-curl $domain_dir/final-url.txt > $domain_dir/gf/gf-php-curl.txt
gf php-errors $domain_dir/final-url.txt > $domain_dir/gf/gf-php-errors.txt
gf php-serialized $domain_dir/final-url.txt > $domain_dir/gf/gf-php-serialized.txt
gf php-sinks $domain_dir/final-url.txt > $domain_dir/gf/gf-php-sinks.txt
gf php-sources $domain_dir/final-url.txt > $domain_dir/gf/gf-php-sources.txt
gf rce $domain_dir/final-url.txt > $domain_dir/gf/gf-rce.txt
gf redirect $domain_dir/final-url.txt > $domain_dir/gf/gf-redirect.txt
gf sqli $domain_dir/final-url.txt > $domain_dir/gf/gf-sqli.txt
gf ssrf $domain_dir/final-url.txt > $domain_dir/gf/gf-ssrf.txt
gf ssti $domain_dir/final-url.txt > $domain_dir/gf/gf-ssti.txt
gf upload-fields $domain_dir/final-url.txt > $domain_dir/gf/gf-upload-fields.txt
gf xml $domain_dir/final-url.txt > $domain_dir/gf/gf-xml.txt
gf xss $domain_dir/final-url.txt > $domain_dir/gf/gf-xss.txt

}

pem_check(){

mkdir -p $domain_dir/param
param="$domain_dir/param"

python3 /root/tools/ParamSpider/paramspider.py -d $domain -l high --e woff,css,js,png,svg,jpg,jpeg,eot,ttf,webp,gif,webp,JPG,PNG,CSS,JS,WEBP,GIF,Jpg,JPEG --output $param/paramspider_result.txt

gf xss $param/paramspider_result.txt > $param/param-xss.txt
gf redirect $param/paramspider_result.txt > $param/param-redirect.txt
gf potential $param/paramspider_result.txt > $param/param-potential.txt
gf wordpress $param/paramspider_result.txt > $param/param-wordpress.txt

# +++ URL WITH PERA-METER

cat $domain_dir/final-url.txt | grep -a -i \= > $param/url-with-param.txt

ffuf -c -u "FUZZ" -w $param/url-with-param.txt -mc 200 -of csv -o $param/tmp.txt

cat $param/tmp.txt | grep http | awk -F "," '{print $1}' > $param/live-url-with-param.txt

mv $param/tmp.txt $param/live-url-with-param.csv

rm $param/url-with-param.txt

cat $param/live-url-with-param.txt | qsreplace -a FUZZ | tee $param/live-url-with-FUZZ.txt

}

js_find(){

mkdir -p $domain_dir/js

#Greb All JS And Check Live

cat $domain_dir/final-url.txt | grep -iE "\.js$" >> $domain_dir/js/tmp.txt
sort -u $domain_dir/js/tmp.txt > $domain_dir/js/all-js.txt
rm $domain_dir/js/tmp.txt
cat  $domain_dir/js/all-js.txt | httpx -follow-redirects -silent -status-code | grep "[200]" | cut -d ' ' -f1 | sort -u > $domain_dir/js/live-js.txt

#Find URL - SUB - VAR in JS

python3 /root/tools/JSFinder/JSFinder.py -u https://$domain -d -ou $domain_dir/js/jd_url.txt -os $domain_dir/js/jd_domain.txt

cat  $domain_dir/js/all-js.txt  | while read url ; do bash ~/tools/jsvar.sh $url | sort -u  >> $domain_dir/js/js-var.txt; done;

#Find Secrets From JS Files

mkdir -p $domain_dir/js/secretfinder
secret_finder="$domain_dir/js/secretfinder"

python3 /root/tools/SecretFinder/SecretFinder.py -i https://$domain -e -o cli > $secret_finder/secretfinder.txt

cat $domain_dir/js/live-js.txt | while read LINE; do python3 /root/tools/SecretFinder/SecretFinder.py -i $LINE -o cli; done | tee -a $secret_finder/secretfinder.txt

cat $secret_finder/secretfinder.txt | grep 'google_api' -B 1 | sort -u > $secret_finder/google_api.txt
cat $secret_finder/secretfinder.txt | grep 'google_captcha' -B 1 | sort -u > $secret_finder/google_captcha.txt
cat $secret_finder/secretfinder.txt | grep 'google_oauth' -B 1 | sort -u > $secret_finder/google_oauth.txt
cat $secret_finder/secretfinder.txt | grep 'amazon_aws_access_key_id' -B 1 | sort -u > $secret_finder/amazon_aws_access_key_id.txt
cat $secret_finder/secretfinder.txt | grep 'amazon_mws_auth_toke' -B 1 | sort -u > $secret_finder/amazon_mws_auth_toke.txt
cat $secret_finder/secretfinder.txt | grep 'amazon_aws_url' -B 1 | sort -u > $secret_finder/amazon_aws_url.txt
cat $secret_finder/secretfinder.txt | grep 'facebook_access_token' -B 1 | sort -u > $secret_finder/facebook_access_token.txt
cat $secret_finder/secretfinder.txt | grep 'authorization_basic' -B 1 | sort -u > $secret_finder/authorization_basic.txt
cat $secret_finder/secretfinder.txt | grep 'authorization_bearer' -B 1 | sort -u > $secret_finder/authorization_bearer.txt
cat $secret_finder/secretfinder.txt | grep 'authorization_api' -B 1 | sort -u > $secret_finder/authorization_api.txt
cat $secret_finder/secretfinder.txt | grep 'mailgun_api_key' -B 1 | sort -u > $secret_finder/mailgun_api_key.txt
cat $secret_finder/secretfinder.txt | grep 'twilio_api_key' -B 1 | sort -u > $secret_finder/twilio_api_key.txt
cat $secret_finder/secretfinder.txt | grep 'twilio_account_sid' -B 1 | sort -u > $secret_finder/twilio_account_sid.txt
cat $secret_finder/secretfinder.txt | grep 'twilio_app_sid' -B 1 | sort -u > $secret_finder/twilio_app_sid.txt
cat $secret_finder/secretfinder.txt | grep 'paypal_braintree_access_token' -B 1 | sort -u > $secret_finder/paypal_braintree_access_token.txt
cat $secret_finder/secretfinder.txt | grep 'square_oauth_secret' -B 1 | sort -u > $secret_finder/square_oauth_secret.txt
cat $secret_finder/secretfinder.txt | grep 'square_access_token' -B 1 | sort -u > $secret_finder/square_access_token.txt
cat $secret_finder/secretfinder.txt | grep 'stripe_standard_api' -B 1 | sort -u > $secret_finder/stripe_standard_api.txt
cat $secret_finder/secretfinder.txt | grep 'stripe_restricted_api' -B 1 | sort -u > $secret_finder/stripe_restricted_api.txt
cat $secret_finder/secretfinder.txt | grep 'github_access_token' -B 1 | sort -u > $secret_finder/github_access_token.txt
cat $secret_finder/secretfinder.txt | grep 'rsa_private_key' -B 1 | sort -u > $secret_finder/rsa_private_key.txt
cat $secret_finder/secretfinder.txt | grep 'ssh_dsa_private_key' -B 1 | sort -u > $secret_finder/ssh_dsa_private_key.txt
cat $secret_finder/secretfinder.txt | grep 'ssh_dc_private_key' -B 1 | sort -u > $secret_finder/ssh_dc_private_key.txt
cat $secret_finder/secretfinder.txt | grep 'pgp_private_block' -B 1 | sort -u > $secret_finder/pgp_private_block.txt
cat $secret_finder/secretfinder.txt | grep 'json_web_token' -B 1 | sort -u > $secret_finder/json_web_token.txt

}

dir_search(){

python3 /root/tools/dirsearch/dirsearch.py -r -t 100 -u https://$domain -o $domain_dir/dir_search.html --format html

ffuf -w $wordlist -u https://$domain/FUZZ -v -o $domain_dir/ffuf.html -of html -t 100

}

raw_urls
gf_urls
pem_check
js_find
dir_search

}

#Attack Start

basic_attacks(){

echo "Nuclei - HTTP"

#nuclei -u http://$domain -o $domain_dir/nuclei-full-http.txt -t /root/nuclei-templates/

echo "Nuclei - HTTPS"

nuclei -u https://$domain -o $domain_dir/nuclei-full-https.txt -t /root/nuclei-templates/

#2

}

#End Message

recon_complete(){
endtime=$(date)
curl -s -X POST $telegram_url_msg -d chat_id=$telegram_id -d text="Domain Hunting For $domain is Finish @ $endtime. Good Bye"
}

#Functions Start

start_message
wayback_check
basic_attacks
recon_complete

echo "\n\n ====> Good Bye \n"