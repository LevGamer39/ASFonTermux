#!/data/data/com.termux/files/usr/bin/bash

# Удаление Zsh и зависимостей
apt remove --purge -y zsh

# Удаление файлов и каталогов, связанных с Zsh
rm -rf $HOME/.oh-my-zsh
rm -f $HOME/.zshrc
rm -f $HOME/.zsh_history
rm -f $HOME/.zcompdump*
rm -f $HOME/.zsh-completions
rm -f $HOME/.zsh-autosuggestions
rm -f $HOME/.zsh-syntax-highlighting
rm -f $HOME/.zsh-history-substring-search

# Восстановление оболочки на bash
chsh -s bash

echo "Zsh и его компоненты успешно удалены. Перезапустите Termux!"