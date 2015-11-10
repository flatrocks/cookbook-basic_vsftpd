  #
# Cookbook Name:: basic_vsftpd
# Recipe:: chroot_list
#
# Copyright 2015, Roll No Rocks llc
#
# All rights reserved - Do Not Redistribute
#
# Creates chroot_list file.

chroot_list_file = node['basic_vsftpd']['config']['chroot_list_file']
chroot_list_file_dir = ::File.dirname(chroot_list_file)
directory chroot_list_file_dir do
  recursive true
  owner 'root'
  group 'root'
  mode '0500'
  not_if do ::File.exists?(chroot_list_file_dir) end
end
file chroot_list_file do
  content node['basic_vsftpd']['chroot_list'].join("\n")
  owner 'root'
  group 'root'
  mode '0400'
end
