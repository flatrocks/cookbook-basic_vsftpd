# encoding: utf-8
require 'serverspec'
set :backend, :exec

describe service('vsftpd') do
  it { should be_enabled }
  it { should be_running }
end

describe file('/etc/vsftpd.conf.orig') do
  it { should be_file }
end

describe file('/etc/vsftpd.conf') do
  it { should be_file }
  it { should contain('chroot_list_file=/etc/vsftpd.chroot_list')}
  it { should contain('userlist_file=/etc/vsftpd.user_list')}
end
