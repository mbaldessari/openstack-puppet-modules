require 'spec_helper'

describe 'neutron::agents::metadata' do

  let :pre_condition do
    "class { 'neutron': rabbit_password => 'passw0rd' }"
  end

  let :params do
    { :package_ensure    => 'present',
      :debug             => false,
      :enabled           => true,
      :auth_url          => 'http://localhost:35357/v2.0',
      :auth_insecure     => false,
      :auth_region       => 'RegionOne',
      :auth_tenant       => 'services',
      :auth_user         => 'neutron',
      :auth_password     => 'password',
      :shared_secret     => 'metadata-secret',
    }
  end

  let :test_facts do
    { :operatingsystem           => 'default',
      :operatingsystemrelease    => 'default',
      :processorcount            => '2'
    }
  end

  shared_examples_for 'neutron metadata agent' do

    it { is_expected.to contain_class('neutron::params') }

    it 'configures neutron metadata agent service' do
      is_expected.to contain_service('neutron-metadata').with(
        :name    => platform_params[:metadata_agent_service],
        :enable  => params[:enabled],
        :ensure  => 'running',
        :require => 'Class[Neutron]',
        :tag     => 'neutron-service',
      )
      is_expected.to contain_service('neutron-metadata').that_subscribes_to('Package[neutron]')
    end

    context 'with manage_service as false' do
      before :each do
        params.merge!(:manage_service => false)
      end
      it 'should not start/stop service' do
        is_expected.to contain_service('neutron-metadata').without_ensure
      end
    end

    it 'configures metadata_agent.ini' do
      is_expected.to contain_neutron_metadata_agent_config('DEFAULT/debug').with(:value => params[:debug])
      is_expected.to contain_neutron_metadata_agent_config('DEFAULT/auth_url').with(:value => params[:auth_url])
      is_expected.to contain_neutron_metadata_agent_config('DEFAULT/auth_insecure').with(:value => params[:auth_insecure])
      is_expected.to contain_neutron_metadata_agent_config('DEFAULT/auth_ca_cert').with(:value => '<SERVICE DEFAULT>')
      is_expected.to contain_neutron_metadata_agent_config('DEFAULT/auth_region').with(:value => params[:auth_region])
      is_expected.to contain_neutron_metadata_agent_config('DEFAULT/admin_tenant_name').with(:value => params[:auth_tenant])
      is_expected.to contain_neutron_metadata_agent_config('DEFAULT/admin_user').with(:value => params[:auth_user])
      is_expected.to contain_neutron_metadata_agent_config('DEFAULT/admin_password').with(:value => params[:auth_password])
      is_expected.to contain_neutron_metadata_agent_config('DEFAULT/admin_password').with_secret( true )
      is_expected.to contain_neutron_metadata_agent_config('DEFAULT/nova_metadata_ip').with(:value => '<SERVICE DEFAULT>')
      is_expected.to contain_neutron_metadata_agent_config('DEFAULT/nova_metadata_port').with(:value => '<SERVICE DEFAULT>')
      is_expected.to contain_neutron_metadata_agent_config('DEFAULT/nova_metadata_protocol').with(:value => '<SERVICE DEFAULT>')
      is_expected.to contain_neutron_metadata_agent_config('DEFAULT/metadata_workers').with(:value => facts[:processorcount])
      is_expected.to contain_neutron_metadata_agent_config('DEFAULT/metadata_backlog').with(:value => '<SERVICE DEFAULT>')
      is_expected.to contain_neutron_metadata_agent_config('DEFAULT/metadata_proxy_shared_secret').with(:value => params[:shared_secret])
      is_expected.to contain_neutron_metadata_agent_config('DEFAULT/cache_url').with(:ensure => 'absent')
    end
  end

  shared_examples_for 'neutron metadata agent with auth_insecure and auth_ca_cert set' do
    let :params do
      { :auth_ca_cert  => '/some/cert',
        :auth_insecure => true,
        :auth_password => 'blah',
        :shared_secret => '42'
      }
    end

    it 'configures certificate' do
      is_expected.to contain_neutron_metadata_agent_config('DEFAULT/auth_ca_cert').with_value('/some/cert')
      is_expected.to contain_neutron_metadata_agent_config('DEFAULT/auth_insecure').with_value('true')
    end
  end

  context 'on Debian platforms' do
    let :facts do
      @default_facts.merge(test_facts.merge(
        { :osfamily => 'Debian' }
      ))
    end

    let :platform_params do
      { :metadata_agent_package => 'neutron-metadata-agent',
        :metadata_agent_service => 'neutron-metadata-agent' }
    end

    it 'installs neutron metadata agent package' do
      is_expected.to contain_package('neutron-metadata').with(
        :ensure => params[:package_ensure],
        :name   => platform_params[:metadata_agent_package],
        :tag    => ['openstack', 'neutron-package'],
      )
    end

    it_configures 'neutron metadata agent'
    it_configures 'neutron metadata agent with auth_insecure and auth_ca_cert set'
    it 'configures subscription to neutron-metadata package' do
      is_expected.to contain_service('neutron-metadata').that_subscribes_to('Package[neutron-metadata]')
    end
  end

  context 'on Red Hat platforms' do
    let :facts do
      @default_facts.merge(test_facts.merge({
         :osfamily => 'RedHat',
         :operatingsystemrelease => '7'
      }))
    end

    let :platform_params do
      { :metadata_agent_service => 'neutron-metadata-agent' }
    end

    it_configures 'neutron metadata agent'
    it_configures 'neutron metadata agent with auth_insecure and auth_ca_cert set'

  end

end
