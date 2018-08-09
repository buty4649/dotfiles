define :ln do
  dotfile = File.join(ENV['HOME'], params[:name])
  link dotfile do
    to File.expand_path("files/#{params[:name]}", File.dirname(__FILE__))
  end
end

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
  ln file
end
