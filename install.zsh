#!/bin/zsh

#Basic Install

mkdir -p /root/tools

#sudo timedatectl set-timezone Asia/Kolkata

apt update && apt full-upgrade -y

apt install -y zsh curl wget command-not-found git htop ncdu glances exa zsh-autosuggestions zsh-syntax-highlighting python-is-python3 python3-pip parallel at tree cron golang-go

chsh -s $(which zsh)

export PATH=$PATH:/root/go/bin

#Tools Install Start

apt install -y amass subfinder sublist3r ffuf dirsearch naabu figlet

## Go Tools

go install -v github.com/harleo/knockknock@latest
go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
go install -v github.com/cgboal/sonarsearch/cmd/crobat@latest
go install -v github.com/tomnomnom/assetfinder@latest
go install -v github.com/gwen001/github-subdomains@latest
go install -v github.com/tomnomnom/httprobe@latest
go install -v github.com/hakluke/hakcheckurl@latest
go install -v github.com/haccer/subjack@latest
go install -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest
go install -v github.com/tomnomnom/waybackurls@latest
go install -v github.com/lc/gau/v2/cmd/gau@latest
go install -v github.com/hakluke/hakrawler@latest
go install -v github.com/tomnomnom/qsreplace@latest
go install -v github.com/ipinfo/cli/ipinfo@latest

# GF

cd /root/
go install -v github.com/tomnomnom/gf@latest
mkdir .gf
git clone https://github.com/1ndianl33t/Gf-Patterns
mv Gf-Patterns/*.json ~/.gf
cp -r /root/go/pkg/mod/github.com/tomnomnom/gf@v0.0.0-20200618134122-dcd4c361f9f5/examples/* /root/.gf
rm -rf Gf-Patterns

## Findomain

cd /root/
wget https://github.com/findomain/findomain/releases/latest/download/findomain-linux
chmod +x findomain-linux
mv findomain-linux findomain
mv findomain /usr/bin

## SubScraper

git clone https://github.com/m8r0wn/subscraper
cd subscraper
python3 setup.py install
cd ..
rm -rf subscraper

## ParamSpider

cd /root/tools
git clone https://github.com/devanshbatham/ParamSpider
cd ParamSpider
pip3 install -r requirements.txt

## JSFINDER + LinkFinder

cd /root/tools
git clone https://github.com/Threezh1/JSFinder.git
git clone https://github.com/GerbenJavado/LinkFinder.git
python3 setup.py install

## SecretFinder

cd /root/tools
git clone https://github.com/m4ll0k/SecretFinder
cd SecretFinder
pip install -r requirements.txt

## Dirsearch

cd /root/tools
git clone https://github.com/maurosoria/dirsearch.git
cd dirsearch
pip3 install -r requirements.txt

## JSVAR

cd /root/tools
wget https://gist.githubusercontent.com/KathanP19/d2cda2f99c0b60d64b76ee6039b37e47/raw/eb105a4de06502b2732df9d682c61189c3703685/jsvar.sh
chmod +x jsvar.sh

## Byp4xx

cd /root/tools
git clone https://github.com/lobuhi/byp4xx.git
cd byp4xx
chmod u+x byp4xx.py

## Bypass 403

cd /root/tools
git clone https://github.com/iamj0ker/bypass-403
cd bypass-403
chmod +x bypass-403.sh

## 403bypasser

cd /root/tools
git clone https://github.com/yunemse48/403bypasser
cd 403bypasser
pip install -r requirements.txt

cd ~

echo 'export PATH="$PATH":/root/go/bin' >> ~/.zshrc

source ~/.zshrc; clear