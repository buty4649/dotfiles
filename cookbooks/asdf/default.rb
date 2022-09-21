version = 'v0.10.2'
homedir = ENV['HOME']
asdf_dir = File.join(homedir, '.asdf')
execute 'git clone asdf' do
  command "git clone https://github.com/asdf-vm/asdf.git #{asdf_dir} --branch #{version}"
  only_if "test ! -d #{asdf_dir}"
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
"
__COMMAND__
  end
end
