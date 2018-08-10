execute 'Install ulauncher' do
  version = '4.1.0.r1'
  command <<__COMMAND__
wget -P /tmp https://github.com/Ulauncher/Ulauncher/releases/download/#{version}/ulauncher_#{version}_all.deb
sudo apt-get install -y /tmp/ulauncher_#{version}_all.deb
rm /tmp/ulauncher_#{version}_all.deb
__COMMAND__
end
