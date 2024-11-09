#!/bin/bash

# Изменение репозиториев Termux
termux-change-repo

# Обновление пакетов и установка необходимых пакетов Termux
yes | pkg upgrade -y
pkg install -y proot-distro android-tools git make clang python termux-tools

# Установка и настройка хранилища
termux-setup-storage

# Ожидание для подтверждения доступа к хранилищу
sleep 10

# Установка дистрибутива Ubuntu в proot-distro
proot-distro install ubuntu

# Переход в папку загрузок и копирование ASF в корень Ubuntu
cd storage/downloads
cp -r ASF /data/data/com.termux/files/usr/var/lib/proot-distro/installed-rootfs/ubuntu/root/

# Выполнение команд внутри Ubuntu для установки и настройки
proot-distro login ubuntu <<EOF
  # Обновление пакетов в Ubuntu
  apt update && apt upgrade -y

  # Установка .NET SDK, Python и pip с выбором временной зоны
  ln -fs /usr/share/zoneinfo/Europe/Kaliningrad /etc/localtime
  dpkg-reconfigure -f noninteractive tzdata
  apt install -y dotnet-sdk-8.0 python3 python3-pip

  # Создание символических ссылок на ASF и ASFBot
  ln -s /root/ASF/ASF-generic/ArchiSteamFarm.sh ArchiSteamFarm.sh
  ln -s /root/ASF/ASFBot-master/ASFBot-master/bot.py bot.py

  # Установка зависимостей для ASFBot
  pip install -r /root/ASF/ASFBot-master/ASFBot-master/requirements.txt --break-system-packages
EOF

# Настройка переменной окружения для .NET в Ubuntu
echo "export DOTNET_GCHeapHardLimit=1C0000000" > /data/data/com.termux/files/usr/var/lib/proot-distro/installed-rootfs/ubuntu/etc/profile.d/dotnet-env.sh

# Клонирование и установка mcrcon
git clone https://github.com/Tiiffi/mcrcon.git
cd mcrcon
make
cp mcrcon /data/data/com.termux/files/usr/bin
cd ..

# Установка модуля mcstatus для Python
pip install mcstatus==6.5.0

#Код query_minecraft
curl -H "Authorization: token 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" -sL https://raw.githubusercontent.com/Levk39/ASFonTermux/refs/heads/main/query_minecraft.py -o query_minecraft.py

#shortcuts
mkdir ~/.shortcuts

cd .shortcuts

curl -H "Authorization: token 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" -sL https://raw.githubusercontent.com/Levk39/ASFonTermux/refs/heads/main/ASF.sh -o ASF.sh

curl -H "Authorization: token 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" -sL https://raw.githubusercontent.com/Levk39/ASFonTermux/refs/heads/main/ASFBot.sh -o ASFBot.sh

curl -H "Authorization: token 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" -sL https://raw.githubusercontent.com/Levk39/ASFonTermux/refs/heads/main/query_minecraft.sh -o query_minecraft.sh

cd ..

#Установка zsh
curl -H "Authorization: token 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" -sL https://raw.githubusercontent.com/Levk39/ASFonTermux/refs/heads/main/removezsh.sh -o removezsh.sh && chmod +x removezsh.sh

curl -H "Authorization: token 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" -sL https://raw.githubusercontent.com/Levk39/ASFonTermux/refs/heads/main/zsh.sh -o zsh.sh && chmod +x zsh.sh && bash zsh.sh