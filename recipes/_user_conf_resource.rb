  #
# Cookbook Name:: basic_vsftpd
# Recipe:: _user_conf_resource
#
# Copyright 2015, Roll No Rocks llc
#
# All rights reserved - Do Not Redistribute
#
# FOR TESTING ONLY!

basic_vsftpd_user_conf 'bob' do
  content "local_root=/some/custom/location\nwrite_enable=NO"
end
