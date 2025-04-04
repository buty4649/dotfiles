# GRUB画面の文字を大きくする
file '/etc/default/grub' do
  action :edit
  block do |content|
    content.sub!(/^#GRUB_GFXMODE=.+?$/, 'GRUB_GFXMODE=1024x768')
  end
end
