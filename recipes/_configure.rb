# encoding: utf-8

include_recipe 'runit'

# Ensure the item name is set
if node['serf']['data_bag']['item_name'].nil?
  fail "`node['serf']['data_bag']['item_name']` must be set!"
end

if node['serf']['cluster']['nodes'].nil?
  fail "`node['serf']['cluster']['nodes']` must be set to either an array or a search term!"
end

# Load the serf settings from data bag + node attributes
serf_sercret = Chef::EncryptedDataBagItem.load(node['serf']['data_bag']['name'],
                                               node['serf']['data_bag']['item_name'])
params_hash = { 'encrypt_key' => serf_sercret['encrypt_key'] }
params_hash.merge!(node['serf']['config']['options']) unless node['serf']['config']['options'].nil?

# Write our serf node configuration
template "#{node['serf']['config']['directory']}/node.json" do
  source 'node_json.erb'
  variables('params' => params_hash)
  notifies :restart, 'service[serf]', :delayed
end

# Configure the new service and enable it
runit_service 'serf'

# Find all serf nodes and randomly join one that is not ourself
cluster_nodes = partial_search(:node, node['serf']['cluster']['nodes'],
                               'keys' => { 'ipaddress' => ['ipaddress'] })
log "Found #{cluster_nodes.count} node(s)"
if cluster_nodes.count > 0
  random_cluster_node = cluster_nodes.sample
  serf_cluster random_cluster_node['ipaddress']
end
