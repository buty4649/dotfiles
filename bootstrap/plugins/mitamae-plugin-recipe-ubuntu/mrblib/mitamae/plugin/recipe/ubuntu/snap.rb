define :snap, action: :install do
  def sudo
    if (ENV["EUID"] || ENV["UID"]) != "0"
      "sudo -p '[local sudo] Password: '"
    end
  end

  name   = params[:name]
  action = params[:action]
  command_prefix = sudo

  if action == :install
    execute "Install #{name} from snapcraft" do
      command "#{command_prefix} snap install #{name}"
      not_if "snap list | grep -q #{name}"
    end
  end
end
