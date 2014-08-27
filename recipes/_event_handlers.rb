# encoding: utf-8

# Only setup the catchall handler, more or other handlers have to be setup via wrappers
if node['serf']['config']['options'] && \
   node['serf']['config']['options']['event_handlers'].include?(
     ::File.join(node['serf']['config']['handlers'], 'catchall.sh')
   )
  serf_handler 'catchall.sh'
end
