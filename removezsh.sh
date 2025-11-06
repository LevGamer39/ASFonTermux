#!/data/data/com.termux/files/usr/bin/bash

# Удаление Zsh
apt remove --purge -y zsh

# Удаление файлов и каталогов, связанных с Zsh
rm -rf $HOME/.oh-my-zsh
rm -rf $HOME/.zshrc
rm -rf $HOME/.zsh_history
rm -rf $HOME/.zcompdump*
rm -rf $HOME/.zsh-completions
rm -rf $HOME/.zsh-autosuggestions
rm -rf $HOME/.zsh-syntax-highlighting
rm -rf $HOME/.zsh-history-substring-search

# Восстановление оболочки на bash
chsh -s bash

echo "Zsh и его компоненты успешно удалены. Перезапустите Termux!"