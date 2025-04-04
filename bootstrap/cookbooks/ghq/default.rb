Dir.mktmpdir do |tmpdir|
  execute 'Install ghq' do
    version = '1.1.5'
    command <<__COMMAND__
wget -P #{tmpdir} https://github.com/x-motemen/ghq/releases/download/v#{version}/ghq_linux_amd64.zip
unzip #{tmpdir}/ghq_linux_amd64.zip -d #{tmpdir}
mv #{tmpdir}/ghq_linux_amd64/ghq ${HOME}/bin/ghq
__COMMAND__
    not_if "ghq -v | grep -q 'version #{version} '"
  end
end

