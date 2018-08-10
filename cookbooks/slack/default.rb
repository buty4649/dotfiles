execute 'Install Slack' do
  version = '3.2.1'
  command <<__COMMAND__
wget -P /tmp https://downloads.slack-edge.com/linux_releases/slack-desktop-#{version}-amd64.deb
sudo apt-get install -y /tmp/slack-desktop-#{version}-amd64.deb
rm /tmp/slack-desktop-#{version}-amd64.deb
__COMMAND__
  not_if 'dpkg -l slack-desktop'
end
