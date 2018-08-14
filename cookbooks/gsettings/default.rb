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

## HiDPI対応
## https://wiki.archlinux.jp/index.php/GNOME/%E3%83%92%E3%83%B3%E3%83%88%E3%81%A8%E3%83%86%E3%82%AF%E3%83%8B%E3%83%83%E3%82%AF#Retina_.28HiDPI.29_.E3.83.87.E3.82.A3.E3.82.B9.E3.83.97.E3.83.AC.E3.82.A4.E3.81.AE.E3.82.B5.E3.83.9D.E3.83.BC.E3.83.88
gsettings "org.gnome.desktop.interface/scaling-factor" do
  value "1"
end
