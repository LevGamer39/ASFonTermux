#!/bin/bash

# Функция: Проверка установленных дистрибутивов
check_distro_installed() {
    # Проверяем, установлен ли Ubuntu
    if [ -d "/data/data/com.termux/files/usr/var/lib/proot-distro/installed-rootfs/ubuntu" ]; then
        ubuntu_installed=true
    else
        ubuntu_installed=false
    fi

    # Проверяем, установлен ли Debian
    if [ -d "/data/data/com.termux/files/usr/var/lib/proot-distro/installed-rootfs/debian" ]; then
        debian_installed=true
    else
        debian_installed=false
    fi
}

# Функция: Запуск ASF в установленном дистрибутиве
run_asf() {
    check_distro_installed

    # Если установлен Ubuntu, запускаем его
    if [ "$ubuntu_installed" = true ]; then
        echo "Запуск ASF на Ubuntu..."
        proot-distro login ubuntu -- bash /root/ASF/ASF-generic/ArchiSteamFarm.sh
    # Если установлен Debian, запускаем его
    elif [ "$debian_installed" = true ]; then
        echo "Запуск ASF на Debian..."
        proot-distro login debian -- bash /root/ASF/ASF-generic/ArchiSteamFarm.sh
    else
        echo "Ни один из дистрибутивов не установлен."
        exit 1
    fi
}

# Запуск основной функции
run_asf