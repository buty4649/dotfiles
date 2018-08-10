homedir = ENV['HOME']
appdir = File.join(homedir, 'apps')

directory appdir

execute 'Download & Install Firefox' do
  command <<__COMMAND__
wget -O /tmp/firefox-latest.tar.bz "https://download.mozilla.org/?product=firefox-latest-ssl&os=linux64&lang=ja"
cd #{appdir}
tar xvf /tmp/firefox-latest.tar.bz
rm /tmp/firefox-latest.tar.bz
__COMMAND__
  only_if "test ! -f '#{appdir}/firefox/firefox'"
end

%w(
  .local
  .local/share
  .local/share/applications
  ).each do |path|
  directory File.join(homedir, path)
end

template File.join(homedir, '.local/share/applications/firefox.desktop') do
  variables(appdir: appdir)
  source 'templates/firefox.desktop.erb'
end
