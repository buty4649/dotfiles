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

define :asdf do
  name = params[:name]
  version = params[:version] || "latest"
  asdf_script = File.join(ENV['HOME'], ".asdf", "asdf.sh")

  execute "Install asdf plugin: #{name}" do
    command <<__COMMAND__
bash -c "
  source #{asdf_script}
  asdf plugin add #{name}
"
__COMMAND__
    not_if <<__COMMAND__
bash -c "
  source #{asdf_script}
  asdf plugin list | grep -q '^#{name}$'
"
__COMMAND__
  end

  execute "Install asdf package: #{name}" do
    command <<__COMMAND__
bash -c "
  source #{asdf_script}
  asdf install #{name} #{version}
  asdf global #{name} #{version}
"
__COMMAND__
  end
end
