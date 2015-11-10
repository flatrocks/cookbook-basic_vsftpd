# encoding: utf-8
require 'spec_helper'

describe 'basic_vsftpd::_user_conf_resource' do
  context 'when the user_config_dir has been set' do
    subject { ChefSpec::SoloRunner.new(:step_into => ['basic_vsftpd_user_conf']) do |node|
      node.set['basic_vsftpd']['config']['user_config_dir'] = '/some/directory'
    end.converge(described_recipe) }

    describe 'the test resource' do
      it 'is created' do
        expect(subject).to create_basic_vsftpd_user_conf('bob')
      end
    end

    describe 'user config file' do
      let(:the_file) {'/some/directory/bob'}
      it 'is created' do
        expect(subject).to create_file(the_file)
      end
      it 'has the right mode, group and owner' do
        expect(subject).to create_file(the_file).with_owner('root').with_group('root').with_mode('0400')
      end
      it 'has the expected content' do
        expect(subject).to render_file(the_file).with_content "local_root=/some/custom/location\nwrite_enable=NO"
      end
    end
  end
end
