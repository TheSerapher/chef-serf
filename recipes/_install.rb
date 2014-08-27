# encoding: utf-8

include_recipe 'ark'

ark 'serf' do # ~FC006
  url node['serf']['package']['url']
  checksum node['serf']['package']['checksum']
  version node['serf']['package']['version']
  has_binaries ['serf']
  strip_components 0
  mode 700
  action :install
end

directory node['serf']['config']['directory'] do
  mode '700'
  user 'root'
  group 'root'
  action :create
end
