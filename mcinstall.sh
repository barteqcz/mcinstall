#!/bin/bash

white='\033[0m'
green='\033[0;32m'
red='\033[0;31m'
bold=$(tput bold)
normal=$(tput sgr0)

clear

echo -e "${bold}
 __  __  ____ ___ _   _ ____ _____  _    _     _
|  \/  |/ ___|_ _| \ | / ___|_   _|/ \  | |   | |
| |\/| | |    | ||  \| \___ \ | | / _ \ | |   | |
| |  | | |___ | || |\  |___) || |/ ___ \| |___| |___
|_|  |_|\____|___|_| \_|____/ |_/_/   \_\_____|_____|
${normal}"

echo -e "${bold}Downloading Minecraft...${normal}"
wget https://launcher.mojang.com/download/Minecraft.tar.gz > /dev/null 2>&1

echo -e "${bold}Installing Minecraft...${normal}"
tar -xvzf Minecraft.tar.gz > /dev/null 2>&1
sudo rm -f /usr/local/bin/minecraft-launcher > /dev/null 2>&1
sudo mv minecraft-launcher/minecraft-launcher /usr/local/bin/ > /dev/null 2>&1
sudo chmod 755 /usr/local/bin/minecraft-launcher > /dev/null 2>&1
sudo rm -f /usr/share/applications/minecraft-launcher.desktop > /dev/null 2>&1
echo "[Desktop Entry]
Version=1.0
Name=Minecraft Launcher
Comment=Launch Minecraft
Exec=/usr/local/bin/minecraft-launcher
Icon=minecraft
Terminal=false
Type=Application
Categories=Game;" | sudo tee /usr/share/applications/minecraft-launcher.desktop > /dev/null 2>&1
sudo chmod 755 /usr/share/applications/minecraft-launcher.desktop > /dev/null 2>&1

echo -e "${bold}Cleaning up...${normal}"
rm -rf minecraft-launcher > /dev/null 2>&1
rm -f Minecraft.tar.gz > /dev/null 2>&1
echo -e "${bold}Finished ${green}${bold}successfully!${white}${normal}"

echo ""
while true; do
    read -rp "A ${bold}restart${normal} might be required for the launcher to work. ${bold}Do you want to reboot now?${normal} [${bold}Y${normal}/n] " answer
    if [[ "$answer" == "Y" || "$answer" == "y" || "$answer" == "" ]]; then
        reboot
    elif [[ "$answer" == "N" || "$answer" == "n" ]]; then
        break
    else
        echo -e "${bold}${red}Incorrect option.${white}${normal}"
    fi
done
