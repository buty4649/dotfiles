include_recipe "use_sudo::ubuntu"

homedir = ENV['HOME']
user = ENV['USER']

# libevent-dev,unzip is needed by tmux
# zlib1g-dev,libssl-dev,libmysqlclient-dev is needed by ruby
%w[
  build-essential python3 python-is-python3
  libevent-dev unzip zlib1g-dev libssl-dev libmysqlclient-dev
].each do |name|
  package name
end

%w[
  asdf fish-shell lsd rcm
].each do |name|
  include_recipe "../cookbooks/#{name}"
end

%w[
  direnv
  fzf
  ghq
  peco
  ruby
  starship
  tmux
].each do |name|
  asdf name
end

# Windows側のディレクトリにシンボリックリンクを張る
%w[
  Documents
  Downloads
  Pictures
].each do |directory|
  link File.join(homedir, directory) do
    to File.join("/mnt/c/Users", user, directory)
  end
end
