execute 'Install rbenv' do
  command <<__COMMAND__
set -e
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
__COMMAND__
  not_if "test -d ~/.rbenv"
end

execute 'Install ruby-build' do
  command <<__COMMAND__
set -e
mkdir -p ~/.rbenv/plugins
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
__COMMAND__
  not_if "test -d ~/.rbenv/plugins"
end
