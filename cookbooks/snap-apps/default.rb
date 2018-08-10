execute 'Install Firefox from snap' do
  command 'sudo snap install firefox'
  not_if 'snap list firefox'
end
