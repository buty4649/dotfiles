# sudoを使う
class Specinfra::Command::Debian::Base::Package
  def self.install(package, version=nil, option='')
    if version
      full_package = "#{package}=#{version}"
    else
      full_package = package
    end
    "sudo DEBIAN_FRONTEND='noninteractive' apt-get -y -o Dpkg::Options::='--force-confdef' -o Dpkg::Options::='--force-confold' #{option} install #{full_package}"
  end

  def remove(package, option='')
    "sudo DEBIAN_FRONTEND='noninteractive' apt-get -y #{option} remove #{package}"
  end
end
