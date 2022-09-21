execute 'add-apt-repository ppa:fish-shell/release-3' do
  command 'sudo add-apt-repository -y ppa:fish-shell/release-3 && apt-get update -qq'
  not_if 'grep -qR fish-shell /etc/apt/sources.list.d'
end

package 'fish'

#execute 'Install sharship' do
#  version = '0.47.0'
#  command <<__COMMAND__
#wget -P /tmp https://github.com/starship/starship/releases/download/v#{version}/starship-x86_64-unknown-linux-gnu.tar.gz
#tar -C ${HOME}/bin -zxf /tmp/starship-x86_64-unknown-linux-gnu.tar.gz
#rm /tmp/starship-x86_64-unknown-linux-gnu.tar.gz
#__COMMAND__
#  not_if "starship -V | grep -q 'starship #{version}'"
#end
