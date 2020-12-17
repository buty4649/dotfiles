execute 'Install zoom-client from snapcraft' do
  command "sudo snap install zoom-client"
  not_if "snap list | grep -q zoom-client"
end
