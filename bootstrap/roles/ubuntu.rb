include_recipe "use_sudo::ubuntu"
include_recipe "ubuntu::gsettings"
include_recipe "ubuntu::snap"

%w[
  firefox thunderbird rcm tmux ulauncher cica-font
  tig peco gsettings openvpn mozc ghq alacritty fish-shell
  lsd vscode fzf textern rbenv python3 zoom rambox envchain
  docker flameshot
].each do |name|
  include_recipe "../cookbooks/#{name}"
end

homedir = ENV['HOME']

{
  'ダウンロード' => 'Downloads',
  'デスクトップ' => 'Desktop',
  'ドキュメント' => 'Documents',
  'ピクチャ'     => 'Picture',
}.each do |src, dst|
  link File.join(homedir, dst) do
    to src
    only_if "test -d #{File.join(homedir, src)}"
  end
end
