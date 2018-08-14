define :gsettings, value:nil do
  schema, key = params[:name].split(/\//,2)
  value = params[:value]

  execute "gsettings set #{schema} #{key} #{value}" do
    command "gsettings set #{schema} #{key} \"#{value}\""
    not_if "gsettings get #{schema} #{key} | grep -F \"#{value}\""
  end
end

# CapsLockをCtrlにする
gsettings 'org.gnome.desktop.input-sources/xkb-options' do
  value "['ctrl:nocaps']"
end

# Dockの設定
gsettings 'org.gnome.shell.extensions.dash-to-dock/dock-position' do
  value "BOTTOM"
end

## 自動的に隠す
gsettings 'org.gnome.shell.extensions.dash-to-dock/dock-fixed' do
  value "false"
end

## macOSのドック風にする
gsettings 'org.gnome.shell.extensions.dash-to-dock/extend-height' do
  value "false"
end

## アクティブなウインドウの背景を変える
gsettings 'org.gnome.shell.extensions.dash-to-dock/unity-backlit-items' do
  value "true"
end
