# snapインストールするのでFirefoxは削除してしまう
%w[
  firefox
  firefox-locale-en
  firefox-locale-ja
].each do |name|
  package name do
    action :remove
  end
end

execute 'Install Firefox from snapcraft' do
  command "snap install firefox"
  only_if %Q{test -z "`snap list | grep firefox`"}
end
