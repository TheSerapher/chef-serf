# encoding: utf-8
include Chef::Mixin::ShellOut

def whyrun_supported?
  true
end

use_inline_resources

action :create do
  file = ::File.join(node['serf']['config']['handlers'], new_resource.name)
  log "Creating new handler #{file}"
  directory "handler-dir-#{new_resource.name}" do
    path node['serf']['config']['handlers']
    action :create
    mode '750'
    user 'root'
    group 'root'
  end
  # Add a new handler from template
  t = template file do
    cookbook new_resource.cookbook if new_resource.cookbook
    mode '750'
    user 'root'
    group 'root'
    action :create
  end
  new_resource.updated_by_last_action(t.updated_by_last_action?)
end

action :delete do
  file = ::File.join(node['serf']['config']['handlers'], new_resource.name)
  if ::File.exist?(file) && ::File.delete(file)
    log "Removed #{file} from handlers"
    new_resource.updated_by_last_action(true)
  end
end
