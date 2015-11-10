  #
# Cookbook Name:: basic_vsftpd
# Recipe:: userlist
#
# Copyright 2015, Roll No Rocks llc
#
# All rights reserved - Do Not Redistribute
#
# Creates userlist file

userlist_file = node['basic_vsftpd']['config']['userlist_file']
userlist_file_dir = ::File.dirname(userlist_file)
directory userlist_file_dir do
  recursive true
  owner 'root'
  group 'root'
  mode '0500'
  not_if do ::File.exists?(userlist_file_dir) end
end
file userlist_file do
  content node['basic_vsftpd']['userlist'].join("\n")
  owner 'root'
  group 'root'
  mode '0400'
end
