homedir = ENV['HOME']
user = ENV['USER']

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
