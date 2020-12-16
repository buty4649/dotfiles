include_recipe "use_sudo::ubuntu"

%w[
  firefox thunderbird rcm tmux ulauncher cica-font
  tig peco gsettings openvpn mozc ghq alacritty fish-shell
  lsd vscode
].each do |name|
  include_recipe "../cookbooks/#{name}"
end

homedir = ENV['HOME']

{
  'ダウンロード' => 'Downloads',
  'デスクトップ' => 'Desktop',
  'ドキュメント' => 'Document',
  'ピクチャ'     => 'Picture',
}.each do |src, dst|
  link File.join(homedir, dst) do
    to src
    only_if "test -d #{File.join(homedir, src)}"
  end
end
