include_recipe "use_sudo::ubuntu"

include_recipe "../cookbooks/apt"

# libevent-dev,unzip is needed by tmux
# zlib1g-dev,libssl-dev,libmysqlclient-dev,libffi-dev,libyaml-dev is needed by ruby
%w[
  build-essential
  libevent-dev unzip
  zlib1g-dev libssl-dev libmysqlclient-dev libffi-dev libyaml-dev
  wslu
].each do |name|
  package name
end

include_recipe "../cookbooks/fish-shell"
include_recipe "../cookbooks/chezmoi"
include_recipe "../cookbooks/mise"
include_recipe "../cookbooks/docker"

execute 'Set default editor to vim' do
  command 'sudo update-alternatives --set editor /usr/bin/vim.basic'
  not_if 'update-alternatives --query editor | grep "Value: /usr/bin/vim.basic"'
end

package 'wl-clipboard'
package 'age' # chezmoi encryptに必要

# Windows側のディレクトリにシンボリックリンクを張る
userprofile = `cmd.exe /C "set user" 2> /dev/null | awk -F= '/^USERPROFILE=/{print $2}'`.chomp
userprofile_path = `wslpath "#{userprofile}"`.chomp
link File.join(homedir, "UserProfile") do
  to userprofile_path
end

%w[
  Documents
  Downloads
  Pictures
].each do |directory|
  link File.join(homedir, directory) do
    to File.join(userprofile_path, directory)
  end
end

# キーリピートの設定
registry_key = 'HKEY_CURRENT_USER\\Control Panel\\Accessibility\\Keyboard Response'
desired_values = {
  'AutoRepeatDelay' => '170',    # キー押下後にリピート開始するまでの遅延
  'AutoRepeatRate' => '9',       # キーリピートの速度（小さいほど速い）
  'BounceTime' => '0',           # チャタリング防止の無効化（キー入力の無視時間）
  'DelayBeforeAcceptance' => '0' # 入力を受け付けるまでの遅延（即時受け付け）
}

# 現在の設定を一括取得
stdout = run_command("reg.exe query \"#{registry_key}\" || true").stdout

current_values = {}
stdout.each_line do |line|
  if line =~ /^\s+(\S+)\s+\S+\s+(.+)$/
    name = $1
    value = $2.strip
    current_values[name] = value
    MItamae.logger.debug "#{name} #{value}"
  end
end

# 必要な設定のみ変更
desired_values.each do |name, value|
  next if current_values[name] == value

  execute "set #{name}" do
    command %Q{reg.exe add "#{registry_key}" /v #{name} /d #{value} /f}
  end
end
