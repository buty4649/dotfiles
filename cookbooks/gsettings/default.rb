define :gsettings, value:nil do
  schema, key = params[:name].split(/\//,2)
  value = params[:value]

  execute "gsettings set #{schema} #{key} #{value}" do
    command "gsettings set #{schema} #{key} \"#{value}\""
    not_if "gsettings get #{schema} #{key} | grep -F \"#{value}\""
  end
end

gsettings 'org.gnome.desktop.input-sources/xkb-options' do
  value "['ctrl:nocaps']"
end
