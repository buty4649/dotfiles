package 'flameshot'

# デフォルトのScreenshotのショートカットキーを無効化
gsettings 'org.gnome.settings-daemon.plugins.media-keys' do
  key 'screenshot'
  value '[]'
end

# カスタムショートカットキーを作りflameshotを設定
gsettings 'org.gnome.settings-daemon.plugins.media-keys' do
  key 'custom-keybindings'
  value "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']"
end
{
  "binding" => "Print",
  "command" => "flameshot gui",
  "name"    => "screenshot",
}.each do |k, v|
  gsettings 'org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/' do
    key   k
    value v
  end
end
