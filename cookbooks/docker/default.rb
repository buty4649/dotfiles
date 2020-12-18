%w[
  apt-transport-https ca-certificates
  curl gnupg-agent software-properties-common
].each do |name|
  package name
end

execute 'Add gpg key' do
  command 'curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -'
  not_if 'apt-key finger 0EBFCD88 | grep -q .'
end

execute 'Add apt repository' do
  command <<__COMMAND__
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
__COMMAND__
  not_if 'grep -q download.docker.com /etc/apt/sources.list.d/*'
end

%w[docker-ce docker-ce-cli containerd.io].each {|name| package name }

execute 'Add docker group to current user' do
  command 'usermod -G docker -a ykky'
  not_if 'id -nG $USER | grep -q docker'
end
