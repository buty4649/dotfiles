homedir = ENV['HOME']

directory File.join(homedir, 'bin')

%w(
  .bash_profile
  .bashrc
  .git_template
  .gitconfig
  .gvimrc
  .peco
  .tigrc
  .tmux.conf
  .vim
  .vimrc
  bin/git-open
  bin/tmux-snippets.sh
).each do |file|
  dotfile = File.join(homedir, file)
  link dotfile do
    to File.expand_path("files/#{file}", File.dirname(__FILE__))
    force true
  end
end
