package 'rbenv'

execute 'Install ruby-build' do
  command <<__COMMAND__
mkdir -p "$(rbenv root)"/plugins
git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
__COMMAND__
  not_if "test -d $(rbenv root)/plugins"
end
