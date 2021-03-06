require 'spec_helper'
describe 'manila' do
  let :req_params do
    {:rabbit_password => 'guest', :sql_connection => 'mysql+pymysql://user:password@host/database'}
  end

  let :facts do
    @default_facts.merge({:osfamily => 'Debian'})
  end

  describe 'with only required params' do
    let :params do
      req_params
    end

    it { is_expected.to contain_class('manila::logging') }
    it { is_expected.to contain_class('manila::params') }

    it 'should contain default config' do
      is_expected.to contain_manila_config('DEFAULT/rpc_backend').with(
        :value => 'rabbit'
      )
      is_expected.to contain_manila_config('DEFAULT/notification_driver').with(
        :value => 'messaging'
      )
      is_expected.to contain_manila_config('DEFAULT/control_exchange').with(
        :value => 'openstack'
      )
      is_expected.to contain_manila_config('oslo_messaging_rabbit/rabbit_password').with(
        :value => 'guest',
        :secret => true
      )
      is_expected.to contain_manila_config('oslo_messaging_rabbit/rabbit_host').with(
        :value => '127.0.0.1'
      )
      is_expected.to contain_manila_config('oslo_messaging_rabbit/rabbit_port').with(
        :value => '5672'
      )
      is_expected.to contain_manila_config('oslo_messaging_rabbit/rabbit_hosts').with(
        :value => '127.0.0.1:5672'
      )
      is_expected.to contain_manila_config('oslo_messaging_rabbit/rabbit_ha_queues').with(
        :value => false
      )
      is_expected.to contain_manila_config('oslo_messaging_rabbit/rabbit_virtual_host').with(
        :value => '/'
      )
      is_expected.to contain_manila_config('oslo_messaging_rabbit/rabbit_userid').with(
        :value => 'guest'
      )
      is_expected.to contain_manila_config('DEFAULT/verbose').with(
        :value => '<SERVICE DEFAULT>'
      )
      is_expected.to contain_manila_config('DEFAULT/debug').with(
        :value => '<SERVICE DEFAULT>'
      )
      is_expected.to contain_manila_config('DEFAULT/storage_availability_zone').with(
        :value => 'nova'
      )
      is_expected.to contain_manila_config('DEFAULT/api_paste_config').with(
        :value => '/etc/manila/api-paste.ini'
      )
      is_expected.to contain_manila_config('DEFAULT/rootwrap_config').with(
        :value => '/etc/manila/rootwrap.conf'
      )
      is_expected.to contain_manila_config('DEFAULT/state_path').with(
        :value => '/var/lib/manila'
      )
      is_expected.to contain_manila_config('oslo_concurrency/lock_path').with(
        :value => '/tmp/manila/manila_locks'
      )
      is_expected.to contain_manila_config('DEFAULT/log_dir').with(:value => '/var/log/manila')
    end

    it { is_expected.to contain_file('/etc/manila/manila.conf').with(
      :owner   => 'manila',
      :group   => 'manila',
      :mode    => '0600',
      :require => 'Package[manila]'
    ) }

    it { is_expected.to contain_file('/etc/manila/api-paste.ini').with(
      :owner   => 'manila',
      :group   => 'manila',
      :mode    => '0600',
      :require => 'Package[manila]'
    ) }

  end
  describe 'with modified rabbit_hosts' do
    let :params do
      req_params.merge({'rabbit_hosts' => ['rabbit1:5672', 'rabbit2:5672']})
    end

    it 'should contain many' do
      is_expected.to_not contain_manila_config('oslo_messaging_rabbit/rabbit_host')
      is_expected.to_not contain_manila_config('oslo_messaging_rabbit/rabbit_port')
      is_expected.to contain_manila_config('oslo_messaging_rabbit/rabbit_hosts').with(
        :value => 'rabbit1:5672,rabbit2:5672'
      )
      is_expected.to contain_manila_config('oslo_messaging_rabbit/rabbit_ha_queues').with(
        :value => true
      )
    end
  end

  describe 'with a single rabbit_hosts entry' do
    let :params do
      req_params.merge({'rabbit_hosts' => ['rabbit1:5672']})
    end

    it 'should contain many' do
      is_expected.to_not contain_manila_config('oslo_messaging_rabbit/rabbit_host')
      is_expected.to_not contain_manila_config('oslo_messaging_rabbit/rabbit_port')
      is_expected.to contain_manila_config('oslo_messaging_rabbit/rabbit_hosts').with(
        :value => 'rabbit1:5672'
      )
      is_expected.to contain_manila_config('oslo_messaging_rabbit/rabbit_ha_queues').with(
        :value => true
      )
    end
  end

  describe 'with SSL enabled' do
    let :params do
      req_params.merge!({
        :rabbit_use_ssl     => true,
        :kombu_ssl_ca_certs => '/path/to/ssl/ca/certs',
        :kombu_ssl_certfile => '/path/to/ssl/cert/file',
        :kombu_ssl_keyfile  => '/path/to/ssl/keyfile',
        :kombu_ssl_version  => 'TLSv1'
      })
    end

    it do
      is_expected.to contain_manila_config('oslo_messaging_rabbit/rabbit_use_ssl').with_value(true)
      is_expected.to contain_manila_config('oslo_messaging_rabbit/kombu_ssl_ca_certs').with_value('/path/to/ssl/ca/certs')
      is_expected.to contain_manila_config('oslo_messaging_rabbit/kombu_ssl_certfile').with_value('/path/to/ssl/cert/file')
      is_expected.to contain_manila_config('oslo_messaging_rabbit/kombu_ssl_keyfile').with_value('/path/to/ssl/keyfile')
      is_expected.to contain_manila_config('oslo_messaging_rabbit/kombu_ssl_version').with_value('TLSv1')
    end
  end

  describe 'with SSL enabled without kombu' do
    let :params do
      req_params.merge!({
        :rabbit_use_ssl     => true,
      })
    end

    it do
      is_expected.to contain_manila_config('oslo_messaging_rabbit/rabbit_use_ssl').with_value(true)
      is_expected.to contain_manila_config('oslo_messaging_rabbit/kombu_ssl_ca_certs').with_ensure('absent')
      is_expected.to contain_manila_config('oslo_messaging_rabbit/kombu_ssl_certfile').with_ensure('absent')
      is_expected.to contain_manila_config('oslo_messaging_rabbit/kombu_ssl_keyfile').with_ensure('absent')
      is_expected.to contain_manila_config('oslo_messaging_rabbit/kombu_ssl_version').with_value('TLSv1')
    end
  end

  describe 'with SSL disabled' do
    let :params do
      req_params.merge!({
        :rabbit_use_ssl     => false,
        :kombu_ssl_version  => 'TLSv1'
      })
    end

    it do
      is_expected.to contain_manila_config('oslo_messaging_rabbit/rabbit_use_ssl').with_value(false)
      is_expected.to contain_manila_config('oslo_messaging_rabbit/kombu_ssl_ca_certs').with_ensure('absent')
      is_expected.to contain_manila_config('oslo_messaging_rabbit/kombu_ssl_certfile').with_ensure('absent')
      is_expected.to contain_manila_config('oslo_messaging_rabbit/kombu_ssl_keyfile').with_ensure('absent')
      is_expected.to contain_manila_config('oslo_messaging_rabbit/kombu_ssl_version').with_ensure('absent')
    end
  end

  describe 'with amqp_durable_queues disabled' do
    let :params do
      req_params
    end

    it { is_expected.to contain_manila_config('oslo_messaging_rabbit/amqp_durable_queues').with_value(false) }
  end

  describe 'with amqp_durable_queues enabled' do
    let :params do
      req_params.merge({
        :amqp_durable_queues => true,
      })
    end

    it { is_expected.to contain_manila_config('oslo_messaging_rabbit/amqp_durable_queues').with_value(true) }
  end

  describe 'with sqlite' do
    let :params do
      {
        :sql_connection        => 'sqlite:////var/lib/manila/manila.sqlite',
        :rabbit_password       => 'guest',
      }
    end

    it { is_expected.to_not contain_class('mysql::python') }
    it { is_expected.to_not contain_class('mysql::bindings') }
    it { is_expected.to_not contain_class('mysql::bindings::python') }
  end

  describe 'with SSL socket options set' do
    let :params do
      {
        :use_ssl         => true,
        :cert_file       => '/path/to/cert',
        :ca_file         => '/path/to/ca',
        :key_file        => '/path/to/key',
        :rabbit_password => 'guest',
      }
    end

    it { is_expected.to contain_manila_config('DEFAULT/ssl_ca_file').with_value('/path/to/ca') }
    it { is_expected.to contain_manila_config('DEFAULT/ssl_cert_file').with_value('/path/to/cert') }
    it { is_expected.to contain_manila_config('DEFAULT/ssl_key_file').with_value('/path/to/key') }
  end

  describe 'with SSL socket options set to false' do
    let :params do
      {
        :use_ssl         => false,
        :cert_file       => false,
        :ca_file         => false,
        :key_file        => false,
        :rabbit_password => 'guest',
      }
    end

    it { is_expected.to contain_manila_config('DEFAULT/ssl_ca_file').with_ensure('absent') }
    it { is_expected.to contain_manila_config('DEFAULT/ssl_cert_file').with_ensure('absent') }
    it { is_expected.to contain_manila_config('DEFAULT/ssl_key_file').with_ensure('absent') }
  end

  describe 'with SSL socket options set wrongly configured' do
    let :params do
      {
        :use_ssl         => true,
        :ca_file         => '/path/to/ca',
        :key_file        => '/path/to/key',
        :rabbit_password => 'guest',
      }
    end

    it_raises 'a Puppet::Error', /The cert_file parameter is required when use_ssl is set to true/
  end

  describe 'with amqp rpc supplied' do

    let :params do
      {
        :sql_connection         => 'mysql+pymysql://user:password@host/database',
        :rpc_backend            => 'zmq',
      }
    end

    it { is_expected.to contain_manila_config('DEFAULT/rpc_backend').with_value('zmq') }
    it { is_expected.to contain_manila_config('oslo_messaging_amqp/server_request_prefix').with_value('exclusive') }
    it { is_expected.to contain_manila_config('oslo_messaging_amqp/broadcast_prefix').with_value('broadcast') }
    it { is_expected.to contain_manila_config('oslo_messaging_amqp/group_request_prefix').with_value('unicast') }
    it { is_expected.to contain_manila_config('oslo_messaging_amqp/container_name').with_value('guest') }
    it { is_expected.to contain_manila_config('oslo_messaging_amqp/idle_timeout').with_value('0') }
    it { is_expected.to contain_manila_config('oslo_messaging_amqp/trace').with_value(false) }
    it { is_expected.to contain_manila_config('oslo_messaging_amqp/allow_insecure_clients').with_value(false) }
  end

  describe 'with amqp SSL disable' do
    let :params do
      {
        :rabbit_password => 'guest',
      }
    end

    it do
      is_expected.to contain_manila_config('oslo_messaging_amqp/ssl_key_password').with_ensure('absent')
      is_expected.to contain_manila_config('oslo_messaging_amqp/ssl_ca_file').with_ensure('absent')
      is_expected.to contain_manila_config('oslo_messaging_amqp/ssl_cert_file').with_ensure('absent')
      is_expected.to contain_manila_config('oslo_messaging_amqp/ssl_key_file').with_ensure('absent')
    end
  end

  describe 'with amqp SSL enabled' do
    let :params do
      {
        :rabbit_password       => 'guest',
        :amqp_ssl_ca_file      => '/path/to/ssl/ca/certs',
        :amqp_ssl_cert_file    => '/path/to/ssl/cert/file',
        :amqp_ssl_key_file     => '/path/to/ssl/keyfile',
        :amqp_ssl_key_password => 'guest',
      }
    end

    it do
      is_expected.to contain_manila_config('oslo_messaging_amqp/ssl_key_password').with_value('guest')
      is_expected.to contain_manila_config('oslo_messaging_amqp/ssl_ca_file').with_value('/path/to/ssl/ca/certs')
      is_expected.to contain_manila_config('oslo_messaging_amqp/ssl_cert_file').with_value('/path/to/ssl/cert/file')
      is_expected.to contain_manila_config('oslo_messaging_amqp/ssl_key_file').with_value('/path/to/ssl/keyfile')
    end
  end

  describe 'with amqp SSL enabled without amqp_ssl_key_password' do
    let :params do
      {
        :rabbit_password        => 'guest',
        :amqp_ssl_ca_file      => '/path/to/ssl/ca/certs',
        :amqp_ssl_cert_file    => '/path/to/ssl/cert/file',
        :amqp_ssl_key_file     => '/path/to/ssl/keyfile',
      }
    end

    it do
      is_expected.to contain_manila_config('oslo_messaging_amqp/ssl_key_password').with_ensure('absent')
      is_expected.to contain_manila_config('oslo_messaging_amqp/ssl_ca_file').with_value('/path/to/ssl/ca/certs')
      is_expected.to contain_manila_config('oslo_messaging_amqp/ssl_cert_file').with_value('/path/to/ssl/cert/file')
      is_expected.to contain_manila_config('oslo_messaging_amqp/ssl_key_file').with_value('/path/to/ssl/keyfile')
    end
  end

end
