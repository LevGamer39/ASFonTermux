#!/bin/bash

# Переменная для Authorization token
AUTH_TOKEN="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"

# Функция: Настройка хранилища
setup_storage() {
    termux-setup-storage
    echo "Ожидание 5 секунд для завершения..."
    sleep 1
    for i in {5..1}; do
        echo "Осталось: $i секунд..."
        sleep 1
    done
}

# Функция: Выбор дистрибутива
choose_distro() {
    echo "Выберите дистрибутив для установки:"
    echo "1. Ubuntu"
    echo "2. Debian"
    read -p "Введите 1 или 2 (по умолчанию будет Ubuntu): " distro_choice

    if [ "$distro_choice" = "1" ]; then
        distro_name="ubuntu"
    elif [ "$distro_choice" = "2" ]; then
        distro_name="debian"
    else
        echo "Некорректный ввод. По умолчанию будет установлен Ubuntu."
        distro_name="ubuntu"
    fi

    # Таймер после выбора дистрибутива
    echo "Ожидание 5 секунд перед изменением репозиториев..."
    sleep 1
    for i in {5..1}; do
        echo "Осталось: $i секунд..."
        sleep 1
    done
}

# Функция: Изменение репозиториев Termux
change_repo() {
    termux-change-repo
}

# Функция: Установка базовых пакетов Termux
install_termux_packages() {
    yes | pkg upgrade -y
    pkg install -y proot-distro android-tools git make clang python termux-tools neofetch ruby openssh build-essential ffmpeg tor
    apt install php wget -y
    gem update
    gem update --system 3.5.23
}

# Функция: Установка выбранного дистрибутива
install_distro() {
    proot-distro install $distro_name
}

# Функция: Настройка ASF в дистрибутиве
setup_asf_in_distro() {
    cd storage/downloads
    cp -r ASF /data/data/com.termux/files/usr/var/lib/proot-distro/installed-rootfs/$distro_name/root/
    cd ~

    proot-distro login $distro_name <<EOF
        apt update && apt upgrade -y
        apt install libicu-dev -y
        ln -fs /usr/share/zoneinfo/Europe/Kaliningrad /etc/localtime
        dpkg-reconfigure -f noninteractive tzdata

        # Установка .NET вручную
        wget https://dot.net/v1/dotnet-install.sh
        chmod +x dotnet-install.sh
        ./dotnet-install.sh --channel 9.0

        apt install -y python3 python3-pip
        ln -s /root/ASF/ASF-generic/ArchiSteamFarm.sh ArchiSteamFarm.sh
        ln -s /root/ASF/ASFBot-master/ASFBot-master/bot.py bot.py
        pip install -r /root/ASF/ASFBot-master/ASFBot-master/requirements.txt --break-system-packages
EOF

    # Установка переменных окружения
    echo 'export DOTNET_GCHeapHardLimit=1C0000000' > /data/data/com.termux/files/usr/var/lib/proot-distro/installed-rootfs/$distro_name/etc/profile.d/dotnet-env.sh
    echo 'export PATH=$HOME/.dotnet:$PATH' >> /data/data/com.termux/files/usr/var/lib/proot-distro/installed-rootfs/$distro_name/etc/profile.d/dotnet-env.sh
}

# Функция: Установка mcrcon
install_mcrcon() {
    git clone https://github.com/Tiiffi/mcrcon.git
    cd mcrcon
    make
    cp mcrcon /data/data/com.termux/files/usr/bin
    cd ~
}

# Функция: Установка Python модулей
install_python_modules() {
    pip install mcstatus==6.5.0 colorama yt-dlp
}

# Функция: Установка query_minecraft
query_minecraft() {
curl -H "Authorization: token $AUTH_TOKEN" -sL https://raw.githubusercontent.com/Levk39/ASFonTermux/refs/heads/main/query_minecraft.py -o query_minecraft.py
}

# Функция: Настройка ярлыков
setup_shortcuts() {
    mkdir ~/.shortcuts
    cd .shortcuts

    curl -H "Authorization: token $AUTH_TOKEN" -sL https://raw.githubusercontent.com/Levk39/ASFonTermux/refs/heads/main/ASF.sh -o ASF.sh
    curl -H "Authorization: token $AUTH_TOKEN" -sL https://raw.githubusercontent.com/Levk39/ASFonTermux/refs/heads/main/ASFBot.sh -o ASFBot.sh
    curl -H "Authorization: token $AUTH_TOKEN" -sL https://raw.githubusercontent.com/Levk39/ASFonTermux/refs/heads/main/query_minecraft.sh -o query_minecraft.sh

    cd ~
}

# Функция: Установка Zsh
install_zsh() {
    curl -H "Authorization: token $AUTH_TOKEN" -sL https://raw.githubusercontent.com/Levk39/ASFonTermux/refs/heads/main/removezsh.sh -o removezsh.sh && chmod +x removezsh.sh
    curl -H "Authorization: token $AUTH_TOKEN" -sL https://raw.githubusercontent.com/Levk39/ASFonTermux/refs/heads/main/zsh.sh -o zsh.sh && chmod +x zsh.sh && bash zsh.sh
}

# Функция: Установка lolcat
install_lolcat() {
    wget https://github.com/busyloop/lolcat/archive/master.zip
    unzip master.zip
    cd lolcat-master/bin
    gem install lolcat
    cd ~
    rm -f /data/data/com.termux/files/usr/etc/motd

    echo 'neofetch --ascii_distro android_small | lolcat' >> ~/.zshrc
}

# Функция: Установка фона и шрифта
setup_font_and_theme() {
    cd .termux
    curl -H "Authorization: token $AUTH_TOKEN" -sL https://raw.githubusercontent.com/Levk39/ASFonTermux/refs/heads/main/font.ttf -o font.ttf
    curl -H "Authorization: token $AUTH_TOKEN" -sL https://raw.githubusercontent.com/Levk39/ASFonTermux/refs/heads/main/colors.properties -o colors.properties
    cd ~
}

# Функция: Установка rish
setup_rish() {
    curl -H "Authorization: token $AUTH_TOKEN" -sL https://raw.githubusercontent.com/Levk39/ASFonTermux/refs/heads/main/rish -o rish
    curl -H "Authorization: token $AUTH_TOKEN" -sL https://raw.githubusercontent.com/Levk39/ASFonTermux/refs/heads/main/rish_shizuku.dex -o rish_shizuku.dex
}

# Основной блок скрипта
//setup_storage
//choose_distro
//change_repo
//install_termux_packages
//install_distro
//setup_asf_in_distro
//install_mcrcon
//install_python_modules
query_minecraft
//setup_shortcuts
//install_zsh
//install_lolcat
//setup_font_and_theme
//setup_rish

# Запуск Zsh
//exec zsh