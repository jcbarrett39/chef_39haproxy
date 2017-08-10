#
# Cookbook:: 39haproxy
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.


#node.default['haproxy']['members'] = [
#  {
#    "hostname" => 'webserver1',
#    "ipaddress" => '107.22.128.2',
#    "port" => 80,
#    "ssl_port" => 443
#}]

members = []

all_web_app_a_servers = search('node','role:web_app_a')

all_web_app_a_servers.each do |web_server|
  member = {
    'hostname' => web_server['hostname'],
    'ipaddress' => web_server['ec2']['public_ipv4'],
    'port' => 80,
    'ssl_port' => 443
  }
  members.push(member)
end

node.default['haproxy']['members'] = members 

include_recipe 'haproxy::manual'

