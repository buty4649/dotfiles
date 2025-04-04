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
