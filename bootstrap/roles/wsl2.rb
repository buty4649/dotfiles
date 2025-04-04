include_recipe "use_sudo::ubuntu"

homedir = ENV['HOME']
user = ENV['USER']

include_recipe "../cookbooks/apt"

# libevent-dev,unzip is needed by tmux
# zlib1g-dev,libssl-dev,libmysqlclient-dev,libffi-dev,libyaml-dev is needed by ruby
%w[
  build-essential
  libevent-dev unzip
  zlib1g-dev libssl-dev libmysqlclient-dev libffi-dev libyaml-dev
  wslu
].each do |name|
  package name
end

include_recipe "../cookbooks/fish-shell"
include_recipe "../cookbooks/chezmoi"
include_recipe "../cookbooks/mise"

# Windows側のディレクトリにシンボリックリンクを張る
userprofile = `cmd.exe /C "set user" 2> /dev/null | awk -F= '/^USERPROFILE=/{print $2}'`.chomp
userprofile_path = `wslpath "#{userprofile}"`.chomp
link File.join(homedir, "UserProfile") do
  to userprofile_path
end

%w[
  Documents
  Downloads
  Pictures
].each do |directory|
  link File.join(homedir, directory) do
    to File.join(userprofile_path, directory)
  end
end
