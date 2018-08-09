source ~/.vim/vimrc/init
source ~/.vim/vimrc/plugins
source ~/.vim/vimrc/basic
source ~/.vim/vimrc/keymap

if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif
