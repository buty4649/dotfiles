execute 'Install ulauncher' do
  version = '5.8.1'
  command <<__COMMAND__
wget -P /tmp https://github.com/Ulauncher/Ulauncher/releases/download/#{version}/ulauncher_#{version}_all.deb
sudo apt-get install -y /tmp/ulauncher_#{version}_all.deb
rm /tmp/ulauncher_#{version}_all.deb
__COMMAND__
  not_if "dpkg-query -f '${Status} ${Version}' -W ulauncher | grep -E '^(install|hold) ok installed #{version}$'"
end
