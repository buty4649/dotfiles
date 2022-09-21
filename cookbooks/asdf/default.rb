version = 'v0.10.2'
homedir = ENV['HOME']
asdf_dir = File.join(homedir, '.asdf')
execute 'git clone asdf' do
  command "git clone https://github.com/asdf-vm/asdf.git #{asdf_dir} --branch #{version}"
  only_if "test ! -d #{asdf_dir}"
end
