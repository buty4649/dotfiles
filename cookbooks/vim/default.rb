package "vim"
package "vim-gtk3"

vim_colors_solarizes = File.join(ENV['HOME'], '.vim/plugged/vim-colors-solarized')
execute 'PlugInstall' do
  command 'vim +PlugInstall +qall'
  only_if "test ! -d #{vim_colors_solarizes}"
end
