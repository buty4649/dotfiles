include_recipe "use_sudo::ubuntu"

homedir = ENV['HOME']
user = ENV['USER']

package 'build-essential'

%w[
  asdf fish-shell rcm
].each do |name|
  include_recipe "../cookbooks/#{name}"
end

%w[
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
