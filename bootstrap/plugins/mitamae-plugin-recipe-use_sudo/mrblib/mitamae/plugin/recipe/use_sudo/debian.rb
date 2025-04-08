class MItamae::ResourceExecutor::Package
  alias :__run_command :run_command
  def run_command(*args)
    if args.first =~ /apt-get/
      args[0] = "sudo -p '[local sudo] Password: ' #{args[0]}"
    end
    __run_command(*args)
  end
end

class MItamae::ResourceExecutor::Service
  alias :__run_command :run_command
  def run_command(*args)
    args[0] = "sudo -p '[local sudo] Password: ' #{args[0]}"
    __run_command(*args)
  end
end
