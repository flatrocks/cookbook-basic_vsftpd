# encoding: utf-8
require 'spec_helper'

describe 'basic_vsftpd::userlist' do
  subject { ChefSpec::SoloRunner.new() do |node|
  end.converge(described_recipe) }

  context 'with default userlist file' do
    subject { ChefSpec::SoloRunner.new() do |node|
    end.converge(described_recipe) }
    describe 'the userlist_file' do
      describe 'its directory' do
        it 'is created recursively' do
          allow(File).to receive(:exists?).and_call_original
          allow(File).to receive(:exists?).with('/etc') {false}
          expect(subject).to create_directory('/etc')
        end
        it 'is not created if exists' do
          allow(File).to receive(:exists?).and_call_original
          allow(File).to receive(:exists?).with('/etc') {true}
          expect(subject).to_not create_directory('/etc')
        end
      end
      it 'is created' do
        expect(subject).to create_file('/etc/vsftpd.user_list')
      end
    end
  end

  context 'with custom userlist file' do
    describe 'the userlist_file' do
      let(:file_dir) {'/some/dir'}
      let(:the_file) {file_dir + '/the_users'}
      subject { ChefSpec::SoloRunner.new() do |node|
        node.set['basic_vsftpd']['config']['userlist_file'] = the_file
        node.set['basic_vsftpd']['userlist'] = ['user1', 'user2']
      end.converge(described_recipe) }
      describe 'its directory' do
        it 'is created recursively' do
          expect(subject).to create_directory(file_dir).with_recursive(true)
        end
        it 'has the right mode, group and owner' do
          expect(subject).to create_directory(file_dir).with_owner('root').with_group('root').with_mode('0500')
        end
      end
      it 'is created' do
        expect(subject).to create_file(the_file)
      end
      it 'has the right mode, group and owner' do
        expect(subject).to create_file(the_file).with_owner('root').with_group('root').with_mode('0400')
      end
      it 'has the expected content' do
        expect(subject).to render_file(the_file).with_content "user1\nuser2"
      end
    end
  end

end



