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

include_recipe "../cookbooks/configfiles"
include_recipe "../cookbooks/vim"
include_recipe "../cookbooks/alacritty"
include_recipe "../cookbooks/slack"
include_recipe "../cookbooks/tmux"
include_recipe "../cookbooks/ulauncher"
include_recipe "../cookbooks/snap-apps"
include_recipe "../cookbooks/cica-font"

# Firefox/ThunerbirdはSNAP版を使うのでパッケージ版は消す
%w(firefox thunderbird).each do |name|
  package name do
    action :remove
  end
end

homedir = ENV['HOME']

{
  'ダウンロード' => 'Download',
  'デスクトップ' => 'Desktop',
  'ドキュメント' => 'Document',
  'ピクチャ'     => 'Picture',
}.each do |src, dst|
  link File.join(homedir, dst) do
    to src
    only_if "test -d #{File.join(homedir, src)}"
  end
end
