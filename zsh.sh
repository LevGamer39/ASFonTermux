#!/data/data/com.termux/files/usr/bin/bash

# Обновление и установка зависимостей
apt update && apt upgrade -y
apt install -y libcurl openssl git zsh which unzip

# Установка Oh My Zsh
git clone https://github.com/ohmyzsh/ohmyzsh.git "$HOME/.oh-my-zsh" --depth 1

# Создание .zshrc, если не существует
if [ ! -f "$HOME/.zshrc" ]; then
    cp "$HOME/.oh-my-zsh/templates/zshrc.zsh-template" "$HOME/.zshrc"
fi

# Установка плагинов
git clone https://github.com/zsh-users/zsh-autosuggestions "$HOME/.zsh-autosuggestions" --depth 1
git clone https://github.com/zsh-users/zsh-syntax-highlighting "$HOME/.zsh-syntax-highlighting" --depth 1
git clone https://github.com/zsh-users/zsh-history-substring-search "$HOME/.zsh-history-substring-search" --depth 1
git clone https://github.com/zsh-users/zsh-completions "$HOME/.zsh-completions" --depth 1

# Добавление плагинов в .zshrc
echo "source $HOME/.zsh-autosuggestions/zsh-autosuggestions.zsh" >> "$HOME/.zshrc"
echo "source $HOME/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> "$HOME/.zshrc"
echo "source $HOME/.zsh-history-substring-search/zsh-history-substring-search.zsh" >> "$HOME/.zshrc"
echo "fpath=(\$HOME/.zsh-completions \$fpath)" >> "$HOME/.zshrc"

# Смена оболочки на zsh
chsh -s zsh

echo "Zsh установлен с плагинами. Перезапустите Termux!"