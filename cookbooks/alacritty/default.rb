homedir = ENV['HOME']

configdir = File.join(homedir, '.config/alacritty')
configfile = File.join(configdir, 'alacritty.yml')

directory configdir

link configfile do
  to File.expand_path("files/alacritty.yml", File.dirname(__FILE__))
  force true
end
