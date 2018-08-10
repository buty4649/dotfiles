execute 'Install tmux' do
  command 'sudo apt-get install -y tmux'
  not_if 'dpkg -l tmux'
end
