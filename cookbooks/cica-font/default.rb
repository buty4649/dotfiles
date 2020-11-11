
fontsdir = File.join(ENV['HOME'], '.local/share/fonts')

directory fontsdir

execute 'Install Cica font' do
  version = 'v5.0.2'
  command <<__COMMAND__
wget -P /tmp https://github.com/miiton/Cica/releases/download/#{version}/Cica_#{version}_with_emoji.zip
cd #{fontsdir}
unzip /tmp/Cica_#{version}_with_emoji.zip Cica-Bold.ttf Cica-BoldItalic.ttf Cica-Regular.ttf Cica-RegularItalic.ttf
rm /tmp/Cica_#{version}_with_emoji.zip
__COMMAND__
  not_if 'fc-list | grep Cica:'
end
