# encoding: utf-8
require 'spec_helper'

describe 'basic_vsftpd::default' do
  subject { ChefSpec::SoloRunner.new() do |node|
    node.set['basic_vsftpd']['config']['a_fake_key'] = 'a_fake_value'
  end.converge(described_recipe) }

  it 'installs vsftpd' do
    expect(subject).to install_package('vsftpd')
  end

  describe 'the vsftpd.conf file' do
    let(:config_file) {'/etc/vsftpd.conf'}
    it 'is created' do
      expect(subject).to create_template(config_file)
    end
    it 'has the right mode, group and owner' do
      expect(subject).to create_template(config_file).with_owner('root').with_group('root').with_mode('0400')
    end
    it 'has the expected content' do
      [ 'a_fake_key=a_fake_value',
        'chroot_list_file=/etc/vsftpd.chroot_list',
        'userlist_file=/etc/vsftpd.user_list'
      ].each do |expected_content|
        expect(subject).to render_file(config_file).with_content expected_content
      end
    end
  end

  describe 'the user config directory' do
    context 'when vsftpd user_config_dir is set' do
      let(:the_dir) {'/some/dir'}
      subject { ChefSpec::SoloRunner.new() do |node|
        node.set['basic_vsftpd']['config']['user_config_dir'] = the_dir
      end.converge(described_recipe) }

      it 'is created' do
        expect(subject).to create_directory(the_dir)
      end
      it 'has the right mode, group and owner' do
        expect(subject).to create_directory(the_dir).with_owner('root').with_group('root').with_mode('0500')
      end
    end
    context 'when vsftpd user_config_dir is not set' do
      it 'is not created' do
        # nothing to create, but don't raise error
        expect{subject}.to_not raise_error
      end
    end
  end

  describe 'the vsftpd service' do
    it 'is enabled and started' do
      expect(subject).to enable_service('vsftpd')
      expect(subject).to start_service('vsftpd')
    end
    it 'has the right provider' do
      expect(subject).to enable_service('vsftpd').with_provider Chef::Provider::Service::Upstart
      expect(subject).to start_service('vsftpd').with_provider Chef::Provider::Service::Upstart
    end
  end

end



