#
# Cookbook Name:: basic_vsftpd
# Recipe:: default
#
# Copyright (C) 2015, Tom Wilson
#
# All rights reserved - Do Not Redistribute
#

package 'vsftpd'

vsftpd_config_file = value_for_platform_family(
  'rhel'   => '/etc/vsftpd/vsftpd.conf',
  'debian' => '/etc/vsftpd.conf',
  'default' => '/etc/vsftpd.conf'
)

remote_file 'Copy original vsftpd config' do
  path "#{vsftpd_config_file}.orig"
  source "file://#{vsftpd_config_file}"
  owner 'root'
  group 'root'
  mode '0400'
  action :create_if_missing
end

template vsftpd_config_file do
  source 'vsftpd.conf.erb'
  variables options: node['basic_vsftpd']['config']
  owner 'root'
  group 'root'
  mode '0400'
end

if node['basic_vsftpd']['config']['user_config_dir']
  directory node['basic_vsftpd']['config']['user_config_dir'] do
    recursive true
    owner 'root'
    group 'root'
    mode '0500'
  end
end

service 'vsftpd' do
  provider Chef::Provider::Service::Upstart
  action [:enable, :start]
  supports restart: true
end
