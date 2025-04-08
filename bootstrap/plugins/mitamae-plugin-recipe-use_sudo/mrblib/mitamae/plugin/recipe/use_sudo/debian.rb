class MItamae::ResourceExecutor::Base
  def sudo_prompt
    @sudo_prompt ||= ENV['SUDO_PROMPT'] || "[local sudo] Password: "
  end

  def root?
    ENV['USER'] == 'root'
  end

  def sudo_command(*args)
    unless root?
      args[0] = "sudo -p '#{sudo_prompt}' #{args[0]}"
    end
    args
  end
end

class MItamae::ResourceExecutor::Package
  alias :__run_command :run_command
  def run_command(*args)
    if args.first =~ /apt-get/
      args = sudo_command(*args)
    end
    __run_command(*args)
  end
end

class MItamae::ResourceExecutor::Service
  alias :__run_command :run_command
  def run_command(*args)
    args = sudo_command(*args)
    __run_command(*args)
  end
end

class MItamae::Resource::Execute
  define_attribute :sudo, default: false
end

class MItamae::ResourceExecutor::Execute
  alias :__run_command :run_command
  def run_command(*args)
    if @resource.attributes[:sudo]
      args = sudo_command(*args)
    end
    __run_command(*args)
  end
end

class MItamae::Resource::File
  define_attribute :sudo, default: false
end

class MItamae::ResourceExecutor::File
  alias :__run_command :run_command
  def run_command(*args)
    if @resource.attributes[:sudo] && args.first =~ /^(cp|unlink)\s/
      args = sudo_command(*args)
    end
    __run_command(*args)
  end

  alias :__apply :apply
  def apply
    if @resource.attributes[:sudo] && !desired.exist && FileTest.file?(desired.path)
      run_command("unlink #{desired.path}")
    else
      __apply
    end
  end
end
