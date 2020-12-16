execute 'Install alacritty' do
  version = '0.19.0'
  command <<__COMMAND__
wget -P /tmp https://github.com/Peltoche/lsd/releases/download/#{version}/lsd_#{version}_amd64.deb
sudo apt-get install -y /tmp/lsd_#{version}_amd64.deb
rm /tmp/lsd_#{version}_amd64.deb
__COMMAND__
  not_if "dpkg-query -f '${Status} ${Version}' -W lsd | grep -E '^(install|hold) ok installed #{version.gsub(/\+/, '\+')}$'"
end

