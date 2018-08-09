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
).each do |file|
  dotfile = File.join(ENV['HOME'], file)
  link dotfile do
    to File.expand_path("files/#{file}", File.dirname(__FILE__))
    force true
  end
end
