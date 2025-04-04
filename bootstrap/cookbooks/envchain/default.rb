package 'make'
package 'libsecret-1-dev'
package 'libreadline-dev'

execute 'Install envchain' do
  command <<__COMMAND__
set -e
mkdir -p ~/app
git clone https://github.com/sorah/envchain.git ~/app/envchain
cd ~/app/envchain
make
cp -p envchain ~/.local/bin
__COMMAND__
  not_if 'which envchain'
end
