include_recipe "../cookbooks/configfiles"
include_recipe "../cookbooks/vim"
include_recipe "../cookbooks/alacritty"
include_recipe "../cookbooks/slack"
include_recipe "../cookbooks/tmux"
include_recipe "../cookbooks/ulauncher"

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
