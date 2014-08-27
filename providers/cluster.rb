# encoding: utf-8
include Chef::Mixin::ShellOut

def whyrun_supported?
  true
end

use_inline_resources

action :join do
  cluster(new_resource.ipv4_address, 'join') unless joined?
end

action :leave do
  cluster(new_resource.ipv4_address, 'leave') if joined?
end

def join_status_file
  Chef::Config[:file_cache_path] + '/serf_cluster_joined'
end

def joined?
  ::File.exist?(join_status_file) ? ipaddress = ::File.read(join_status_file) : ipaddress = false
  return false unless ipaddress         # we had no IP, so assume we didn't join
  cmd_obj = shell_out("serf members | grep -q #{ipaddress}")
  log "is_joined?: Node with ip #{ipaddress} already in `serf members`, assuming joined" \
    unless cmd_obj.error?
  !cmd_obj.error?
end

def cluster(ipaddress, action)
  action = 'join' if action.nil?
  cmd_obj = shell_out("serf #{action} #{ipaddress}")
  fail "Unable to join cluster at #{ipaddress}: #{cmd_obj.stdout}" if cmd_obj.error?
  new_resource.updated_by_last_action(true)
  log "#{action}ing cluster using node at #{ipaddress}"
  ::File.write(join_status_file, ipaddress) if action == 'join'
  ::File.delete(join_status_file) if action == 'leave'
end
