include_recipe "use_sudo::ubuntu"

include_recipe "../cookbooks/configfiles"
include_recipe "../cookbooks/vim"
include_recipe "../cookbooks/alacritty"
include_recipe "../cookbooks/slack"
include_recipe "../cookbooks/tmux"
include_recipe "../cookbooks/ulauncher"
include_recipe "../cookbooks/cica-font"
include_recipe "../cookbooks/tig"
include_recipe "../cookbooks/peco"
include_recipe "../cookbooks/firefox"
include_recipe "../cookbooks/gsettings"

# Firefox/ThunerbirdはDL版を使うのでパッケージ版は消す
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
