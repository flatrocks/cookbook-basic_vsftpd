# encoding: utf-8
require 'serverspec'
set :backend, :exec

describe file('/etc/vsftpd.chroot_list') do
  it { should be_file }
  it { should contain "chroot1\nchroot2" }
end
