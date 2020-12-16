# Firefoxの拡張機能の利用に必要
# https://github.com/jlebon/textern
# https://addons.mozilla.org/ja/firefox/addon/textern/

package 'make'

execute 'Clone textern repo' do
    command <<__COMMAND__
mkdir -p ${HOME}/app
cd ${HOME}/app
git clone --recurse-submodules https://github.com/jlebon/textern
cd textern
make native-install USER=1
__COMMAND__
    not_if "test -d ${HOME}/app/textern"
end
