# encoding: utf-8

default['serf']['package']['url']      = 'https://dl.bintray.com/mitchellh/serf/0.6.2_linux_amd64.zip'
default['serf']['package']['version']  = '0.6.2'
default['serf']['package']['checksum'] = 'a75fa07ef6d844c0a9b33990f089da1a6ad1b3ebbb2756bf74f1eec8c8144598'

# General serf configuration
default['serf']['config']['directory'] = '/etc/serf'
default['serf']['config']['handlers'] = node['serf']['config']['directory'] + '/handlers'
default['serf']['config']['options']['interface'] = 'eth0'

# By default, we create a simple catchall handler, you can change this
# if you are able to deploy your own scripts. Otherwise see:
#   http://www.serfdom.io/docs/recipes/event-handler-router.html
default['serf']['config']['options']['event_handlers'] = [ node['serf']['config']['handlers'] + '/catchall.sh'  ]

# Configuration data for Serf cluster, stored in data bag
default['serf']['data_bag']['name'] = 'serf'
default['serf']['data_bag']['item_name'] = 'cluster'

# Search used to find cluster nodes, by default do not include itself since we don't want to join ourselves
default['serf']['cluster']['nodes'] = 'roles:serf-cluster AND tags:serf-cluter-node AND NOT name:' + node.name
