define :gsettings, key:nil, value:nil do
  schema = params[:name]
  key = params[:key]
  value = params[:value].to_s

  execute "gsettings set #{schema} #{key} #{value}" do
    command "gsettings set #{schema} #{key} \"#{value}\""
    not_if "gsettings get #{schema} #{key} | grep -F \"#{value}\""
  end
end
