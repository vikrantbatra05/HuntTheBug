# 🔍 HuntTheBug

[![License](https://img.shields.io/badge/License-GPL%20v3-blue.svg)](https://opensource.org/licenses/GPL-3.0)
[![Platform](https://img.shields.io/badge/Platform-Kali%20Linux-lightgrey.svg)](https://www.kali.org/)
[![Shell](https://img.shields.io/badge/Shell-Zsh-yellow.svg)](https://www.zsh.org/)
[![Bug Bounty](https://img.shields.io/badge/Focus-Bug%20Bounty-red.svg)](https://bugcrowd.com/)
[![Stars](https://img.shields.io/github/stars/vikrantbatra05/HuntTheBug?style=social)](https://github.com/vikrantbatra05/HuntTheBug)

**🚀 Advanced Reconnaissance Framework for Bug Bounty Hunters**

HuntTheBug is a comprehensive, automated reconnaissance toolkit designed specifically for bug bounty hunters and security researchers. It combines **30+ industry-leading tools** into a unified workflow for efficient vulnerability discovery.

## 📖 About

- **🎯 Purpose**: Automated reconnaissance for bug bounty programs
- **🛠️ Tools**: 30+ integrated security tools
- **⚡ Speed**: Parallel execution for maximum efficiency
- **📱 Notifications**: Real-time Telegram bot alerts

## 🎯 Features

### 🔓 Subdomain Enumeration
- Multi-Source Discovery: Amass, SubFinder, Sublist3r, Crobat, AssetFinder, FindDomain, GitHub, Subscraper
- Live Domain Verification: HTTPX + Httprobe for active subdomain detection
- Status Code Analysis: Hakcheckurl for 200/403 subdomain identification

### 🎭 Subdomain Takeover
- Automated Scanning: SubJack + Nuclei for vulnerable subdomain identification
- Real-time Alerts: Telegram bot notifications for immediate threat response

### 🌐 URL & JavaScript Analysis
- Historical URL Discovery: GAU + WaybackURLs for comprehensive endpoint mapping
- Live URL Verification: FFUF for active endpoint confirmation
- Parameter Extraction: ParamSpider for attack surface expansion
- JavaScript Mining: SecretFinder + JSFinder for sensitive data extraction

### 📁 Directory & Port Scanning
- Advanced Fuzzing: Dirsearch with custom wordlists
- Port Discovery: Naabu for open port identification
- Vulnerability Assessment: Nuclei template-based scanning

### 🏢 Organization Intelligence
- Reverse WHOIS: Knockknock for corporate asset mapping
- IP Intelligence: IPinfo for infrastructure analysis

## 🏆 Key Advantages

| 🚀 Speed | 🎯 Accuracy | 🛡️ Security | 📱 Automation |
|---------|------------|-------------|---------------|
| Parallel execution | Multi-tool validation | Safe scanning practices | Real-time notifications |
| Optimized workflows | Comprehensive coverage | Non-intrusive methods | Scheduled scans |
| Smart caching | False positive reduction | Ethical guidelines | Custom alerting |

## 🛠️ Installation

### 📋 System Requirements

| Requirement | Minimum | Recommended |
|-------------|---------|-------------|
| OS | Kali Linux | Kali Linux Latest |
| CPU | 2+ Cores | 4+ Cores |
| RAM | 4GB+ | 8GB+ |
| Storage | 10GB+ | 20GB+ |

> ⚠️ **Warning**: Tested with 1GB RAM + 1 Core CPU resulted in system crashes. Ensure minimum requirements.

### 🚀 Quick Install

```bash
# Install dependencies
apt install zsh git -y

# Clone the repository
cd ~
git clone https://github.com/vikrantbatra05/HuntTheBug

# Navigate and setup
cd ~/HuntTheBug
chmod +x *.zsh

# Run installation script
./install.zsh
```

## ⚙️ Configuration

### Advanced Subdomain Tools Setup

**Amass Configuration:**
```bash
nano ~/HuntTheBug/config/amass-config.ini
```
📖 [Detailed Guide](https://medium.com/@tucuong97/guide-to-amass-how-to-use-amass-more-effectively-for-analyst-domain-a6c430046946)

**SubFinder Configuration:**
```bash
nano ~/HuntTheBug/config/subfinder-config.yaml
```
📖 [Setup Tutorial](https://dhiyaneshgeek.github.io/bug/bounty/2020/02/06/recon-with-me/)

**Telegram Bot Setup:**
```bash
nano ~/HuntTheBug/conf.zsh
```

Resources:
- 🤖 [Bot Token & Chat ID](https://stackoverflow.com/questions/32423837/telegram-bot-how-to-get-a-group-chat-id)
- 🔐 [Alternative Method](https://sean-bradley.medium.com/get-telegram-chat-id-80b575520659)
- 📝 [GitHub Token](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token)

## 🎮 Usage Guide

### Choose Your Mission

| Scope | Target | Purpose |
|-------|--------|---------|
| Medium | *.target.com | Comprehensive recon |
| Small | app.target.com | Focused analysis |
| Organization | company_name | Asset discovery |
| 403 Bypass | https://target.com | Access testing |

### Launch Commands

**Medium Scope Programs:**
```bash
./recon.zsh target.com
```

**Small Scope Programs:**
```bash
./dom_hunt.zsh app.target.com
./dom_hunt.zsh target.com
```

**Organization Intelligence:**
```bash
./org_hunt.zsh organization_name
```

**403 Bypass Testing:**
```bash
./403_hunt.zsh https://target.com
```

## 🔄 Workflow Breakdown

### Medium Scope Reconnaissance (recon.zsh)

| Phase | Tools | Purpose | Output |
|-------|-------|---------|--------|
| 1. Subdomain Discovery | Amass, SubFinder, SubLis3R, Crobat, AssetFinder, FindDomain, GitHub, Subscraper | Comprehensive enumeration | Raw subdomain list |
| 2. Live Verification | HTTPX, Httprobe | Active subdomain identification | Live domains only |
| 3. Status Analysis | Hakcheckurl | 200/403 filtering | Responsive subdomains |
| 4. Takeover Detection | SubJack, Nuclei | Vulnerable subdomain ID | Takeover candidates |
| 5. URL Discovery | GAU, WaybackURLs | Historical endpoint mapping | URL database |
| 6. Live URL Testing | FFUF | Active endpoint verification | Live URLs |
| 7. Parameter Mining | ParamSpider | Attack surface expansion | Parameterized URLs |
| 8. JavaScript Analysis | SecretFinder, JSFinder | Sensitive data extraction | Secrets & endpoints |
| 9. Directory Fuzzing | Dirsearch | Hidden endpoint discovery | Directory structure |
| 10. Port Scanning | Naabu | Open port identification | Port inventory |
| 11. Vulnerability Scanning | Nuclei | Known vulnerability detection | Vulnerability report |

### Small Scope Reconnaissance (dom_hunt.zsh)

| Phase | Tools | Purpose |
|-------|-------|---------|
| URL Discovery | GAU, WaybackURLs | Historical endpoint collection |
| Live Testing | FFUF | Active endpoint verification |
| Pattern Analysis | GF Tool | Security pattern matching |
| Parameter Extraction | ParamSpider | Parameter discovery |
| JavaScript Mining | JSFinder, jsvar.sh | Endpoint and variable extraction |
| Secret Detection | SecretFinder | Sensitive data discovery |
| Directory Fuzzing | Dirsearch | Hidden directory discovery |
| Vulnerability Scanning | Nuclei | Known vulnerability detection |

### Organization Intelligence (org_hunt.zsh)

| Phase | Tools | Purpose |
|-------|-------|---------|
| Domain Discovery | Knockknock | Reverse WHOIS lookup |
| Live Verification | HTTPX | Active domain confirmation |
| IP Intelligence | IPinfo | Infrastructure analysis |

## 🛡️ Security Tools Integration

### Core Reconnaissance Tools

| Tool | Purpose | Repository |
|------|---------|------------|
| Amass | Advanced subdomain enumeration | [OWASP/Amass](https://github.com/OWASP/Amass) |
| SubFinder | Passive subdomain discovery | [projectdiscovery/subfinder](https://github.com/projectdiscovery/subfinder) |
| Nuclei | Vulnerability scanning | [projectdiscovery/nuclei](https://github.com/projectdiscovery/nuclei) |
| HTTPX | HTTP probing | [projectdiscovery/httpx](https://github.com/projectdiscovery/httpx) |
| Naabu | Port scanning | [projectdiscovery/naabu](https://github.com/projectdiscovery/naabu) |

### Specialized Tools

| Tool | Purpose | Repository |
|------|---------|------------|
| SubJack | Subdomain takeover | [haccer/subjack](https://github.com/haccer/subjack) |
| GAU | URL gathering | [lc/gau](https://github.com/lc/gau) |
| FFUF | Web fuzzing | [ffuf/ffuf](https://github.com/ffuf/ffuf) |
| Dirsearch | Directory brute force | [maurosoria/dirsearch](https://github.com/maurosoria/dirsearch) |
| SecretFinder | Secret detection in JS | [m4ll0k/SecretFinder](https://github.com/m4ll0k/SecretFinder) |

### 403 Bypass Tools

| Tool | Repository |
|------|------------|
| byp4xx | [lobuhi/byp4xx](https://github.com/lobuhi/byp4xx) |
| 403bypasser | [yunemse48/403bypasser](https://github.com/yunemse48/403bypasser) |
| bypass-403 | [iamj0ker/bypass-403](https://github.com/iamj0ker/bypass-403) |

## 📁 Project Structure

```
HuntTheBug/
├── config/                 # Configuration files
│   ├── amass-config.ini   # Amass settings
│   └── subfinder-config.yaml  # SubFinder settings
├── wordlist/              # Custom wordlists
│   ├── raft-*.txt        # Raft wordlists
│   ├── all.txt           # Comprehensive wordlist
│   └── dns-resolvers.txt # DNS resolvers
├── *.zsh                 # Main reconnaissance scripts
├── conf.zsh             # Global configuration
├── install.zsh          # Installation script
└── LICENSE             # GPL v3 License
```

## 🤝 Contributing

We welcome contributions! Here's how you can help:

1. **Report Issues**: Found a bug? [Open an issue](https://github.com/vikrantbatra05/HuntTheBug/issues)
2. **Feature Requests**: Have an idea? [Suggest a feature](https://github.com/vikrantbatra05/HuntTheBug/issues)
3. **Pull Requests**: Want to contribute code? [Submit a PR](https://github.com/vikrantbatra05/HuntTheBug/pulls)

### Development Guidelines
- Follow existing code style
- Test your changes thoroughly
- Update documentation as needed
- Ensure compatibility with Kali Linux

## 📜 License

This project is licensed under the **GNU General Public License v3.0** - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

Special thanks to all the open-source tools that make HuntTheBug possible:

### Tool Authors
- **ProjectDiscovery** - For amazing tools like Nuclei, SubFinder, HTTPX, Naabu
- **TomNomNom** - For incredible reconnaissance tools
- **OWASP** - For the Amass project
- **All other tool authors** - Your contributions are invaluable!

### Community
- The bug bounty community for feedback and suggestions
- Security researchers who test and improve these tools
- Everyone who contributes to open-source security

## 📞 Support & Contact

- **Twitter**: [@Vikrant_infosec](https://twitter.com/Vikrant_infosec)
- **Report Issues**: [GitHub Issues](https://github.com/vikrantbatra05/HuntTheBug/issues)
- **Support Development**: [Buy Me a Coffee](https://www.buymeacoffee.com/vikrantbatra05)

## ⚡ Quick Start

```bash
# Clone and install
git clone https://github.com/vikrantbatra05/HuntTheBug
cd ~/HuntTheBug
chmod +x *.zsh
./install.zsh

# Configure
nano conf.zsh

# Start hunting!
./recon.zsh target.com
```

** Happy Hunting! May you find many bugs! 🔥**

*Built with ❤️ for the Bug Bounty Community*
