#!/bin/bash

grep -q /usr/local/bin/bash /etc/shells ||
sudo bash -c "echo /usr/local/bin/bash >> /etc/shells"

CURRENT_SHELL="$(dscl . -read /Users/$USER UserShell | awk '{print $2}')"
[ "$CURRENT_SHELL" != "/usr/local/bin/bash" ] && chsh -s /usr/local/bin/bash

# マウス速度
defaults write "Apple Global Domain" com.apple.mouse.scaling 4.8

# キーリピート
defaults write "Apple Global Domain" InitialKeyRepeat 8
defaults write "Apple Global Domain" KeyRepeat 2

# Finder上で隠しファイルを可視化
defaults write com.apple.finder AppleShowAllFiles true

# すべての拡張子を表示
defaults write "Apple Global Domain" AppleShowAllExtensions -bool true
