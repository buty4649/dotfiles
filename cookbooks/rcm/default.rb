package 'rcm'

homedir = ENV["HOME"]

link File.join(homedir, ".dotfiles") do
  to File.join(Dir.pwd, "files")
end

execute 'Execute rcup' do
  command 'rcup'
end
