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

snap 'firefox'
