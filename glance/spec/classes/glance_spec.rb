require 'spec_helper'

describe 'glance' do

  let :facts do
    @default_facts.merge({
        :osfamily       => 'Debian',
    })
  end

  let :default_params do
    {}
  end

  [
    {},
    {}
  ].each do |param_set|

    describe "when #{param_set == {} ? "using default" : "specifying"} class parameters" do

      let :param_hash do
        param_set == {} ? default_params : params
      end

      let :params do param_set end

      it { is_expected.to contain_file('/etc/glance/').with(
        'ensure'  => 'directory',
        'owner'   => 'glance',
        'mode'    => '0770'
      )}

      it { is_expected.to contain_package('python-openstackclient').with(
        :tag => 'openstack'
      )}

    end
  end

  describe 'on Debian platforms' do
    let :facts do
      @default_facts.merge({
        :osfamily       => 'Debian',
      })
    end
    let(:params) { default_params }

    it { is_expected.to_not contain_package('glance') }
  end

  describe 'on RedHat platforms' do
    let :facts do
      @default_facts.merge({
        :osfamily               => 'RedHat',
        :operatingsystemrelease => '7',
      })
    end
    let(:params) { default_params }

    it { is_expected.to contain_package('openstack-glance').with(
        :tag => ['openstack', 'glance-package'],
    )}
  end

end
