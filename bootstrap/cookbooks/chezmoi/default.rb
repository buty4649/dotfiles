homedir = ENV['HOME']
bindir = File.join(homedir, ".local", "bin")
chezmoi_version = JSON.parse(`wget -qO- https://api.github.com/repos/twpayne/chezmoi/releases/latest`)["name"]

directory bindir
execute 'Download chezmoi binary' do
  url = "https://github.com/twpayne/chezmoi/releases/download/#{chezmoi_version}/chezmoi-linux-amd64"
  output = File.join(bindir, "chezmoi")
  command "wget -O #{output} #{url} && chmod +x #{output}"
  only_if "test ! -f #{output}"
end

execute 'Initialize && Bootstrap chezmoi' do
  chezmoi_config = File.join(homedir, ".config", "chezmoi", "chezmoi.toml")
  command <<-__COMMAND__
    chezmoi init
    chezmoi apply
    chezmoi git -- remote set-url origin git@github.com:buty4649/dotfiles.git
  __COMMAND__
  only_if "test ! -f #{chezmoi_config}"
end
