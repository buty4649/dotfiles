execute 'add-apt-repository ppa:fish-shell/release-4' do
  command 'sudo add-apt-repository -y ppa:fish-shell/release-4 && sudo apt-get update -qq'
  not_if 'grep -qR fish-shell /etc/apt/sources.list.d'
end

package 'fish'

execute 'Set default shell to fish' do
  user = ENV["USER"]

  command "sudo usermod -s /usr/bin/fish #{user}"
  not_if "getent passwd #{user} | cut -d: -f7 | grep -F /usr/bin/fish"
end
