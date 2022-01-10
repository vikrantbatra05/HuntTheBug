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

## Credits Tools USED in 'HuntTheBug Tool' 

1. byp4xx - https://github.com/lobuhi/byp4xx
2. 403bypasser - https://github.com/yunemse48/403bypasser
3. bypass-403 - https://github.com/iamj0ker/bypass-403
4. dirsearch - https://github.com/maurosoria/dirsearch
5. gau - https://github.com/lc/gau
6. waybackurls - https://github.com/tomnomnom/waybackurls
7. ffuf - https://github.com/ffuf/ffuf
8. gf - https://github.com/tomnomnom/gf
9. Gf-Patterns - https://github.com/1ndianl33t/Gf-Patterns
10. ParamSpider - https://github.com/devanshbatham/ParamSpider
11. qsreplace - https://github.com/tomnomnom/qsreplace
12. httpx - https://github.com/projectdiscovery/httpx
13. JSFinder - https://github.com/Threezh1/JSFinder
14. jsvar.sh -https://gist.githubusercontent.com/KathanP19/d2cda2f99c0b60d64b76ee6039b37e47/raw/eb105a4de06502b2732df9d682c61189c3703685/jsvar.sh
15. SecretFinder - https://github.com/m4ll0k/SecretFinder
16. nuclei - https://github.com/projectdiscovery/nuclei
17. ipinfo - https://github.com/ipinfo/cli
18. knockknock - https://github.com/harleo/knockknock
19. naabu - https://github.com/projectdiscovery/naabu
20. Amass - https://github.com/OWASP/Amass
21. subfinder - https://github.com/projectdiscovery/subfinder
22. Sublist3r - https://github.com/aboul3la/Sublist3r
23. SonarSearch - https://github.com/Cgboal/SonarSearch
24. assetfinder - https://github.com/tomnomnom/assetfinder
25. Findomain - https://github.com/Findomain/Findomain
26. github-subdomains -https://github.com/gwen001/github-subdomains
27. subscraper -https://github.com/m8r0wn/subscraper
28. httprobe - https://github.com/tomnomnom/httprobe
29. hakcheckurl - https://github.com/hakluke/hakcheckurl
30. subjack - https://github.com/haccer/subjack

### Other Open Source Tools From Kali APT

zsh curl wget command-not-found git htop ncdu glances exa zsh-autosuggestions zsh-syntax-highlighting python-is-python3 python3-pip parallel at tree cron golang-go amass subfinder sublist3r ffuf dirsearch naabu figlet

Thanks All Open Source Tool Maker 🙏🙏🙏🙏

<br>

<h3 align="left">Support:</h3>
<p><a href="https://www.buymeacoffee.com/vikrantbatra05"> <img align="left" src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" height="50" width="210" alt="vikrantbatra05" /></a></p><br><br>
