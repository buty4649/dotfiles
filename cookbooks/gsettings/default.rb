define :gsettings, key:nil, value:nil do
  schema = params[:name]
  key = params[:key]
  value = params[:value].to_s

  execute "gsettings set #{schema} #{key} #{value}" do
    command "gsettings set #{schema} #{key} \"#{value}\""
    not_if "gsettings get #{schema} #{key} | grep -F \"#{value}\""
  end
end

yamlfile = File.expand_path('gsettings.yml', File.dirname(__FILE__))
settings = File.read(yamlfile)

YAML.load(settings).each_pair do |schema, key_value|
  key_value.each_pair do |key, value|
    gsettings schema do
      key key
      value value
    end
  end
end
