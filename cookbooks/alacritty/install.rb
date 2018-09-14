execute 'Install alacritty' do
  version = '0.1.0-git512fc610+vte'
  command <<__COMMAND__
wget -P /tmp https://github.com/buty4649/alacritty-package-builder/releases/download/v#{version}/alacritty_#{version}_amd64.deb
sudo apt-get install -y /tmp/alacritty_#{version}_amd64.deb
rm /tmp/alacritty_#{version}_amd64.deb
__COMMAND__
  not_if "dpkg-query -f '${Status} ${Version}' -W alacritty | grep -E '^(install|hold) ok installed #{version.gsub(/\+/, '\+')}$'"
end
