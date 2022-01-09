#!/bin/zsh

source conf.zsh

target=$1

echo "\n ===> URL DIR Hunting Start For $target \n"

#Start Messages

starttime=$(date)
curl -s -X POST $telegram_url_msg -d chat_id=$telegram_id -d text="URL DIR Hunting Start For $target @ $starttime"

#---->

raw_urls(){

cat $target_dir/live/live-host.txt | gau > $urls_dir/gau-url.txt

 gau_count=$(grep -c ".*" $urls_dir/gau-url.txt)
 msg_gau_count="GAU : $gau_count"
 curl -s -X POST $telegram_url_msg -d chat_id=$telegram_id -d text="$msg_gau_count"

cat $target_dir/live/live-host.txt | waybackurls > $urls_dir/wayback-urls.txt

 wayback_count=$(grep -c ".*" $urls_dir/wayback-urls.txt)
 msg_wayback_count="Waybackurls : $wayback_count"
 curl -s -X POST $telegram_url_msg -d chat_id=$telegram_id -d text="$msg_wayback_count"

sort -u $urls_dir/gau-url.txt $urls_dir/wayback-urls.txt > $urls_dir/final-url.txt

 total_count=$(grep -c ".*" $urls_dir/final-url.txt)
 msg_total_count="Total URLS : $total_count"
 curl -s -X POST $telegram_url_msg -d chat_id=$telegram_id -d text="$msg_total_count"
 cp $urls_dir/final-url.txt $target_dir/$target-final-url.txt
 curl -F document=@"$target_dir/$target-final-url.txt" $telegram_url

rm $urls_dir/gau-url.txt $urls_dir/wayback-urls.txt

cat $urls_dir/final-url.txt | egrep -v "\.woff|\.ttf|\.svg|\.eot|\.png|\.jpeg|\.jpg|\.svg|\.css|\.ico|\.js|\.gif|\.webp|\.JPG|\.PNG|\.CSS|\.JS|\.WEBP|\.GIF|\.Jpg|\.JPEG" > $urls_dir/clean-urls.txt

 clear_count=$(grep -c ".*" $urls_dir/clean-urls.txt)
 msg_clear_count="Clear URL : $clear_count"
 curl -s -X POST $telegram_url_msg -d chat_id=$telegram_id -d text="$msg_clear_count"
 cp $urls_dir/clean-urls.txt $target_dir/$target-clean-urls.txt
 curl -F document=@"$target_dir/$target-clean-urls.txt" $telegram_url

ffuf -c -u "FUZZ" -w $urls_dir/clean-urls.txt -mc 200 -of csv -o $urls_dir/tmp.txt

cat $urls_dir/tmp.txt | grep http | awk -F "," '{print $1}' > $urls_dir/live-urls.txt

mv $urls_dir/tmp.txt $urls_dir/live-urls.csv

 live_count=$(grep -c ".*" $urls_dir/live-urls.txt)
 msg_live_count="Live URL : $live_count"
 curl -s -X POST $telegram_url_msg -d chat_id=$telegram_id -d text="$msg_live_count"

 cp $urls_dir/live-urls.txt $target_dir/$target-live-urls.txt
 cp $urls_dir/live-urls.csv $target_dir/$target-live-urls.csv
 curl -F document=@"$target_dir/$target-live-urls.txt" $telegram_url
 curl -F document=@"$target_dir/$target-live-urls.csv" $telegram_url

# +++ URL WITH PERA-METER

cat $urls_dir/final-url.txt | grep -a -i \= > $urls_dir/url-with-param.txt

ffuf -c -u "FUZZ" -w $urls_dir/url-with-param.txt -mc 200 -of csv -o $urls_dir/tmp.txt

cat $urls_dir/tmp.txt | grep http | awk -F "," '{print $1}' > $urls_dir/live-url-with-param.txt

mv $urls_dir/tmp.txt $urls_dir/live-url-with-param.csv

rm $urls_dir/url-with-param.txt

cat $urls_dir/live-url-with-param.txt | qsreplace -a FUZZ | tee $urls_dir/live-url-with-FUZZ.txt

 param_count=$(grep -c ".*" $urls_dir/live-url-with-param.txt)
 msg_param_count="Live URL With Parameter : $param_count"
 curl -s -X POST $telegram_url_msg -d chat_id=$telegram_id -d text="$msg_param_count"
 curl -F document=@"$urls_dir/live-url-with-param.txt" $telegram_url
 curl -F document=@"$urls_dir/live-url-with-param.csv" $telegram_url
 curl -F document=@"$urls_dir/live-url-with-FUZZ.txt" $telegram_url

}

pem_check(){

mkdir -p $urls_dir/url_with_pem

for sub in $(cat $target_dir/live/live-host.txt); do

python3 /root/tools/ParamSpider/paramspider.py -d $sub -l high --e woff,css,js,png,svg,jpg,jpeg,eot,ttf,webp,gif,webp,JPG,PNG,CSS,JS,WEBP,GIF,Jpg,JPEG --output $urls_dir/url_with_pem/$sub-param.txt

done

 msg_paramspider_count="ParamSpider Scan Complete"
 curl -s -X POST $telegram_url_msg -d chat_id=$telegram_id -d text="$msg_paramspider_count"

}

js_find(){

mkdir -p $urls_dir/js

cat $urls_dir/final-url.txt | grep -iE "\.js$" >> $urls_dir/js/tmp.txt

sort -u $urls_dir/js/tmp.txt > $urls_dir/js/all-js.txt

rm $urls_dir/js/tmp.txt

cat  $urls_dir/js/all-js.txt | httpx -follow-redirects -silent -status-code | grep "[200]" | cut -d ' ' -f1 | sort -u > $urls_dir/js/live-js.txt

 js_count=$(grep -c ".*" $urls_dir/js/live-js.txt)
 msg_js_count="Live Java Script : $js_count"
 curl -s -X POST $telegram_url_msg -d chat_id=$telegram_id -d text="$msg_js_count"

 cp $urls_dir/js/live-js.txt $target_dir/$target-live-js.txt
 curl -F document=@"$target_dir/$target-live-js.txt" $telegram_url

#->

python3 /root/tools/JSFinder/JSFinder.py -f $target_dir/live/live-host.txt -d -ou $urls_dir/js/jd_url.txt -os $urls_dir/js/jd_domain.txt

 msg_jsfinder_count="JSFinder Scan Complete"
 curl -s -X POST $telegram_url_msg -d chat_id=$telegram_id -d text="$msg_jsfinder_count"
 curl -F document=@"$urls_dir/js/jd_domain.txt" $telegram_url
 curl -F document=@"$urls_dir/js/jd_url.txt" $telegram_url

cat $target_dir/live/live-host.txt | xargs -I %% bash -c 'python3 /root/tools/SecretFinder/SecretFinder.py -i %% -e -o cli' >> $urls_dir/secretfinder.txt

 msg_secretfinder_count="SecretFinder Scan Complete"
 curl -s -X POST $telegram_url_msg -d chat_id=$telegram_id -d text="$msg_secretfinder_count"

 cp $urls_dir/secretfinder.txt $target_dir/$target-secretfinder.txt
 curl -F document=@"$target_dir/$target-secretfinder.txt" $telegram_url

sec_find(){

cat $urls_dir/secretfinder.txt | grep 'google_api' -B 1 | sort -u > $urls_dir/js/google_api.txt

cat $urls_dir/secretfinder.txt | grep 'google_captcha' -B 1 | sort -u > $urls_dir/js/google_captcha.txt

cat $urls_dir/secretfinder.txt | grep 'google_oauth' -B 1 | sort -u > $urls_dir/js/google_oauth.txt

cat $urls_dir/secretfinder.txt | grep 'amazon_aws_access_key_id' -B 1 | sort -u > $urls_dir/js/amazon_aws_access_key_id.txt

cat $urls_dir/secretfinder.txt | grep 'amazon_mws_auth_toke' -B 1 | sort -u > $urls_dir/js/amazon_mws_auth_toke.txt

cat $urls_dir/secretfinder.txt | grep 'amazon_aws_url' -B 1 | sort -u > $urls_dir/js/amazon_aws_url.txt

cat $urls_dir/secretfinder.txt | grep 'facebook_access_token' -B 1 | sort -u > $urls_dir/js/facebook_access_token.txt

cat $urls_dir/secretfinder.txt | grep 'authorization_basic' -B 1 | sort -u > $urls_dir/js/authorization_basic.txt

cat $urls_dir/secretfinder.txt | grep 'authorization_bearer' -B 1 | sort -u > $urls_dir/js/authorization_bearer.txt

cat $urls_dir/secretfinder.txt | grep 'authorization_api' -B 1 | sort -u > $urls_dir/js/authorization_api.txt

cat $urls_dir/secretfinder.txt | grep 'mailgun_api_key' -B 1 | sort -u > $urls_dir/js/mailgun_api_key.txt

cat $urls_dir/secretfinder.txt | grep 'twilio_api_key' -B 1 | sort -u > $urls_dir/js/twilio_api_key.txt

cat $urls_dir/secretfinder.txt | grep 'twilio_account_sid' -B 1 | sort -u > $urls/js/twilio_account_sid.txt

cat $urls_dir/secretfinder.txt | grep 'twilio_app_sid' -B 1 | sort -u > $urls_dir/js/twilio_app_sid.txt

cat $urls_dir/secretfinder.txt | grep 'paypal_braintree_access_token' -B 1 | sort -u > $urls_dir/js/paypal_braintree_access_token.txt

cat $urls_dir/secretfinder.txt | grep 'square_oauth_secret' -B 1 | sort -u > $urls_dir/js/square_oauth_secret.txt

cat $urls_dir/secretfinder.txt | grep 'square_access_token' -B 1 | sort -u > $urls_dir/js/square_access_token.txt

cat $urls_dir/secretfinder.txt | grep 'stripe_standard_api' -B 1 | sort -u > $urls_dir/js/stripe_standard_api.txt

cat $urls_dir/secretfinder.txt | grep 'stripe_restricted_api' -B 1 | sort -u > $urls_dir/js/stripe_restricted_api.txt

cat $urls_dir/secretfinder.txt | grep 'github_access_token' -B 1 | sort -u > $urls_dir/js/github_access_token.txt

cat $urls_dir/secretfinder.txt | grep 'rsa_private_key' -B 1 | sort -u > $urls_dir/js/rsa_private_key.txt

cat $urls_dir/secretfinder.txt | grep 'ssh_dsa_private_key' -B 1 | sort -u > $urls_dir/js/ssh_dsa_private_key.txt

cat $urls_dir/secretfinder.txt | grep 'ssh_dc_private_key' -B 1 | sort -u > $urls_dir/js/ssh_dc_private_key.txt

cat $urls_dir/secretfinder.txt | grep 'pgp_private_block' -B 1 | sort -u > $urls_dir/js/pgp_private_block.txt

cat $urls_dir/secretfinder.txt | grep 'json_web_token' -B 1 | sort -u > $urls_dir/js/json_web_token.txt

}

sec_find

}

gf_find(){

 mkdir -p $urls_dir/gf-urls
 gfurls="$urls_dir/gf-urls"

 cat $urls_dir/final-url.txt | gf auth | tee -a $gfurls/auth
 sleep 10

 cat $urls_dir/final-url.txt | gf aws-keys | tee -a $gfurls/aws-keys
 sleep 10

 cat $urls_dir/final-url.txt | gf badwords | tee -a $gfurls/badwords
 sleep 10

 cat $urls_dir/final-url.txt | gf base64 | tee -a $gfurls/base64

sleep 10

cat $urls_dir/final-url.txt | gf ccode | tee -a $gfurls/ccode

sleep 10

cat $urls_dir/final-url.txt | gf cors | tee -a $gfurls/cors

sleep 10

cat $urls_dir/final-url.txt | gf crypto | tee -a $gfurls/crypto

sleep 10

cat $urls_dir/final-url.txt | gf debug-pages | tee -a $gfurls/debug-pages

sleep 10

cat $urls_dir/final-url.txt | gf execs | tee -a $gfurls/execs

sleep 10

cat $urls_dir/final-url.txt | gf firebase | tee -a $gfurls/firebase

sleep 10

cat $urls_dir/final-url.txt | gf fw | tee -a $gfurls/fw

sleep 10

cat $urls_dir/final-url.txt | gf go-functions | tee -a $gfurls/go-functions

sleep 10

cat $urls_dir/final-url.txt | gf http-auth | tee -a $gfurls/http-auth

sleep 10

cat $urls_dir/final-url.txt | gf idor | tee -a $gfurls/idor

sleep 10

cat $urls_dir/final-url.txt | gf img-traversal | tee -a $gfurls/img-traversal

sleep 10

cat $urls_dir/final-url.txt | gf interestingEXT | tee -a $gfurls/interestingEXT

sleep 10

cat $urls_dir/final-url.txt | gf interestingparams | tee -a $gfurls/interestingparams

sleep 10

cat $urls_dir/final-url.txt | gf interestingsubs | tee -a $gfurls/interestingsubs
sleep 10

cat $urls_dir/final-url.txt | gf ip | tee -a $gfurls/ip

sleep 10

cat $urls_dir/final-url.txt | gf json-sec | tee -a $gfurls/json-sec

sleep 10

cat $urls_dir/final-url.txt | gf jsvar | tee -a $gfurls/jsvar

sleep 10

cat $urls_dir/final-url.txt | gf jwt | tee -a $gfurls/jwt

sleep 10

cat $urls_dir/final-url.txt | gf lfi | tee -a $gfurls/lfi

sleep 10

cat $urls_dir/final-url.txt | gf meg-headers | tee -a $gfurls/meg-headers

sleep 10

cat $urls_dir/final-url.txt | gf parsers | tee -a $gfurls/parsers

sleep 10

cat $urls_dir/final-url.txt | gf php-curl | tee -a $gfurls/php-curl

sleep 10

cat $urls_dir/final-url.txt | gf php-errors | tee -a $gfurls/php-errors

sleep 10

cat $urls_dir/final-url.txt | gf php-serialized | tee -a $gfurls/php-serialized

sleep 10

cat $urls_dir/final-url.txt | gf php-sinks | tee -a $gfurls/php-sinks

sleep 10

cat $urls_dir/final-url.txt | gf php-sources | tee -a $gfurls/php-sources

sleep 10

cat $urls_dir/final-url.txt | gf potential | tee -a $gfurls/potential

sleep 10

cat $urls_dir/final-url.txt | gf rce | tee -a $gfurls/rce

sleep 10

cat $urls_dir/final-url.txt | gf redirect | tee -a $gfurls/redirect

sleep 10

cat $urls_dir/final-url.txt | gf s3-buckets | tee -a $gfurls/s3-buckets

sleep 10

cat $urls_dir/final-url.txt | gf sec | tee -a $gfurls/sec

sleep 10

cat $urls_dir/final-url.txt | gf secrets | tee -a $gfurls/secrets

sleep 10

cat $urls_dir/final-url.txt | gf serial | tee -a $gfurls/serial

sleep 10

cat $urls_dir/final-url.txt | gf servers | tee -a $gfurls/servers

sleep 10

cat $urls_dir/final-url.txt | gf sqli | tee -a $gfurls/sqli

sleep 10

cat $urls_dir/final-url.txt | gf ssrf | tee -a $gfurls/ssrf

sleep 10

cat $urls_dir/final-url.txt | gf ssti | tee -a $gfurls/ssti

sleep 10

cat $urls_dir/final-url.txt | gf strings | tee -a $gfurls/strings

sleep 10

cat $urls_dir/final-url.txt | gf swearwords | tee -a $gfurls/swearwords

sleep 10

cat $urls_dir/final-url.txt | gf takeovers | tee -a $gfurls/takeovers

sleep 10

cat $urls_dir/final-url.txt | gf typos | tee -a $gfurls/typos

sleep 10

cat $urls_dir/final-url.txt | gf upload-fields | tee -a $gfurls/upload-fields

sleep 10

cat $urls_dir/final-url.txt | gf urls | tee -a $gfurls/urls

sleep 10

cat $urls_dir/final-url.txt | gf xml | tee -a $gfurls/xml

sleep 10

cat $urls_dir/final-url.txt | gf xss | tee -a $gfurls/xss

sleep 10

}

#---->

raw_urls
pem_check
js_find
#gf_find

#---->

starttime=$(date)
curl -s -X POST $telegram_url_msg -d chat_id=$telegram_id -d text="URL DIR Hunting Finish For $target @ $starttime"

echo "\n ===> URL DIR Hunting Finish For $target \n"