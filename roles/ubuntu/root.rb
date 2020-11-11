include_recipe '../../cookbooks/alacritty/install.rb'

# Firefox/ThunerbirdはDL版を使うのでパッケージ版は消す
%w(firefox thunderbird).each do |name|
  package name do
    action :remove
  end
end
