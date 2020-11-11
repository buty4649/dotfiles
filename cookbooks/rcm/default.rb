package 'rcm'

homedir = ENV["HOME"]

link File.join(homedir, ".dotfiles") do
  to File.join(Dir.pwd, "files")
end

execute 'Execute rcup' do
  # ~/.bashrcが実体ファイルだとrcupがコケるので消しておく
  command << __COMMAND__
[ -h ~/.bashrc ] || rm ~/.bashrc
rcup
__COMMAND__
end
