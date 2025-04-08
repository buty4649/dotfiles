%w[
  ca-certificates curl
].each do |name|
  package name
end

directory '/etc/apt/keyrings'

execute 'Add gpg key' do
  command 'sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc'
  not_if 'test -f /etc/apt/keyrings/docker.asc'
end

file '/etc/apt/keyrings/docker.asc' do
  mode '0644'
end

arch = run_command('dpkg --print-architecture').stdout.chomp
codename = run_command('lsb_release -cs | tail -1').stdout.chomp

execute 'Add /etc/apt/sources.list.d/docker.list' do
  command <<-__FILE__
    echo "deb [arch=#{arch} signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu #{codename} stable" | sudo tee /etc/apt/sources.list.d/docker.list
  __FILE__
  not_if 'test -f /etc/apt/sources.list.d/docker.list'
  notifies :run, 'execute[apt-get update]', :immediately
end

%w[
  docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
].each {|name| package name }

#execute 'Add docker group to current user' do
#  command 'sudo usermod -G docker -a ykky'
#  not_if 'id -nG $USER | grep -q docker'
#end

# Rootless mode
%w[
  dbus-user-session uidmap systemd-container
  docker-ce-rootless-extras
].each do |name|
  package name
end

%w[docker.service docker.socket].each do |name|
  service name do
    action %i[disable stop]
  end
end

execute 'dockerd-rootless-setuptool.sh install' do
  command 'dockerd-rootless-setuptool.sh install'
end
