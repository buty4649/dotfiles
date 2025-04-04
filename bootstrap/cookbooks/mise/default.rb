homedir = ENV['HOME']
bindir = File.join(homedir, ".local", "bin")
mise_version = JSON.parse(`wget -O- https://api.github.com/repos/jdx/mise/releases/latest`)["name"]

directory bindir
execute 'Download mise binary' do
  url = "https://github.com/jdx/mise/releases/download/#{mise_version}/mise-#{mise_version}-linux-x64"
  output = File.join(bindir, "mise")
  command "wget -O #{output} #{url} && chmod +x #{output}"
  only_if "test ! -f #{output}"
end

execute 'mise install' do
  command 'mise install'
end
