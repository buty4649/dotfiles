package 'virt-manager'
package 'ovmf'

service 'libvirtd' do
  action :start, :enable
end
