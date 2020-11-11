%w[thunderbird thunderbird-locale-ja].each do |name|
  package name do
    action :remove
  end
end
