include_recipe "../cookbooks/configfiles"

execute 'Update /etc/shells' do
  user "root"
  command 'echo /usr/local/bin/bash >> /etc/shells'
  not_if 'grep -q /usr/local/bin/bash /etc/shells'
end

execute 'Change default shell to /usr/local/bin/bash' do
  command 'chsh -s /usr/local/bin/bash'
  only_if 'test "$(dscl . -read /Users/$USER UserShell | awk \'{print $2}\')" != "/usr/local/bin/bash"'
end

execute 'Set mouse speed' do
  command 'defaults write "Apple Global Domain" com.apple.mouse.scaling 4.8'
end

execute 'Set key repeat' do
  command <<_EOS_
defaults write "Apple Global Domain" InitialKeyRepeat 8
defaults write "Apple Global Domain" KeyRepeat 2'
_EOS_
end

execute 'Show all files' do
  command 'defaults write com.apple.finder AppleShowAllFiles true'
end

execute 'Show all extensions' do
  command 'defaults write "Apple Global Domain" AppleShowAllExtensions -bool true'
end
