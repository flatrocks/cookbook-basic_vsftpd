# encoding: utf-8
require 'serverspec'
set :backend, :exec

describe file('/etc/vsftpd.user_list') do
  it { should be_file }
  it { should contain "user1\nuser2" }
end
