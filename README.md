# HuntTheBug

Basic Recon For Bug Bounty Hunter - "HuntTheBug" is Basic Scripts For Sub Domain Enumeration> Live Domain Enumeration > Sub Domain Hijack > URL + JavaScript Scan > Dir Brute Forcing > Open Port Check With Telegram Bot Notification 

Installation Process >

Note : This Tested On **Kali Linux**. You Must Install As `Root User` in Your **Root User Home Folder - /root/.**

System Requiremet > **2 Core CPU + 4 GB RAM**

We Test it On 1GB Ram + 1 Core CPU And System Crash.

## Installation  Process

```
apt install zsh git -y

cd ~

git clone https://github.com/vikrantbatra05/HuntTheBug

cd ~/HuntTheBug

chmod +x *.zsh

./install.zsh

```

## After Install Process >

1. Config Amass + Subfinder For More Sub Domain

How To Config Amass Config File >

[https://medium.com/@tucuong97/guide-to-amass-how-to-use-amass-more-effectively-for-analyst-domain-a6c430046946](https://medium.com/@tucuong97/guide-to-amass-how-to-use-amass-more-effectively-for-analyst-domain-a6c430046946)

How To Config Subfinder Config File >

[https://dhiyaneshgeek.github.io/bug/bounty/2020/02/06/recon-with-me/](https://dhiyaneshgeek.github.io/bug/bounty/2020/02/06/recon-with-me/)


```

nano ~/HuntTheBug/config/amass-config.ini

nano ~/HuntTheBug/config/subfinder-config.yaml


```

1. Config Telegram Boat + Find Domain + Github Token in conf.zsh

How To Config Telegram Boat >

[https://stackoverflow.com/questions/32423837/telegram-bot-how-to-get-a-group-chat-id](https://stackoverflow.com/questions/32423837/telegram-bot-how-to-get-a-group-chat-id)

[https://sean-bradley.medium.com/get-telegram-chat-id-80b575520659](https://sean-bradley.medium.com/get-telegram-chat-id-80b575520659)

How Get Git Hub Token > 

[https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token)

```

nano ~/HuntTheBug/conf.zsh

```

## How To Use >

If You Are Bug Bounty Hunter User This App For 

1. Mediam Scope Program - Example > *.target.com

```
./recon.zsh target.com
```

2. Small Scope Program - Example > app.target.com or target.com

```
./dom_hunt.zsh app.target.com
./dom_hunt.zsh target.com
```

3. Reverse Domain Lookup For Organigation - Example > Google

```
./org_hunt.zsh org_name
```

4. 403 Bypass Check

```
./403_hunt.zsh https://target.com
```

## Recon Flow For Medium Scope [ recon.zsh ]

1. sub_hunt.zsh

```
> Find Subdomain From > Amass + SubFinder + SubLis3R + Crobat + AsseFinder + Find Domain + GitHub SubDomain + Subscraper
```

```
> Check Live Sub Domains From > HTTPX And Httprobe
```

```
> Get 202 And 403 Subdomain With >  Hakcheckurl
``` 

2. sub_jack.zsh

```
> Sub Domain Takeover Check WIth > SubJack + Nuclei
```

3. url_hunt.zsh

```
> Grab URLs From GAU + WaybackURLS
```

```
> Check Live URLS With FFUF
```

```
> Grab All URL WITH PERA-METER With ParamSpider
```

```
> Javascript Hunting Grab All JS File And Find Secret With > SecretFinder + JSFinder
```

4. dir_hunt.zsh

```
> Directory Fuzzing With - Dirsearch
```

5. port_hunt.zsh

```
> Find  All Open Ports With > Naabu
```

6. nuclei_hunt.zsh

```
> Check All Known Valn With Nuclei
```

## Recon Flow For Small Scope [ dom_hunt.zsh ]

```
> Grab All URL From GAU + WayBackURLS > Clean URL > Check Live URL
```

```
> Find Secretes With > GF Tool
```

```
> URLParameter With > ParamSpider
```

```
> Greb All JS And Check Live
```

```
> Find URL - SUB - VAR in JS With JSFinder + jsvar.sh
```

```
> Find Secrets From JS Files with > SecretFinder
```

```
> Directory Brute Forsing With > Dirsearch
```

```
> Check All Known Valn With Nuclei
```

## Recon Flow For Org Reverse Whois [ org_hunt.zsh ]

```
> Grab All Reverse Domains With > knockknock
```

```
> Check Live Domains With > HTTPX
```

```
> Get Domain IP Info With > ipinfo
```

## Final Thought : If You Like This Script And Contribute And Make This Better Contact Me At Twitter - My ID : [@Vikrant_infosec](https://twitter.com/Vikrant_infosec)
