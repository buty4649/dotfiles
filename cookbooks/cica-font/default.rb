
fontsdir = File.join(ENV['HOME'], '.local/share/fonts')

directory fontsdir

execute 'Install Cica font' do
  version = 'v5.0.2'
  command <<__COMMAND__
wget -P /tmp https://github.com/miiton/Cica/releases/download/#{version}/Cica_#{version}.zip
pushd #{fontsdir}
unzip /tmp/Cica_#{version}.zip Cica-Bold.ttf Cica-BoldItalic.ttf Cica-Regular.ttf Cica-RegularItalic.ttf
popd
rm /tmp/Cica_#{version}.zip
__COMMAND__
  not_if 'fc-list | grep Cica:'
end
