require 'spec_helper'

describe 'congress::client' do

  shared_examples 'congress::client' do

    context 'with default parameters' do
      it 'contains congress::params' do
          is_expected.to contain_class('congress::params')
      end
      it 'contains congressclient' do
          is_expected.to contain_package('python-congressclient').with(
              :ensure => 'present',
              :name   => platform_params[:congressclient_package]
          )
      end
    end

  end

  on_supported_os({
    :supported_os   => OSDefaults.get_supported_os
  }).each do |os,facts|
    context "on #{os}" do
      let (:facts) do
        facts.merge!(OSDefaults.get_facts())
      end

      let(:platform_params) do
        case facts[:osfamily]
        when 'Debian'
          { :congressclient_package => 'congressclient' }
        when 'RedHat'
          { :congressclient_package => 'python-congressclient' }
        end
      end
      it_behaves_like 'congress::client'

    end
  end


end