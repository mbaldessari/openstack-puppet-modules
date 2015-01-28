require 'spec_helper'

describe Puppet::Type.type(:vcsrepo).provider(:p4) do

  let(:resource) { Puppet::Type.type(:vcsrepo).new({
    :name     => 'test',
    :ensure   => :present,
    :provider => :p4,
    :path     => '/tmp/vcsrepo',
  })}

  let(:provider) { resource.provider }

  before :each do
    Puppet::Util.stubs(:which).with('p4').returns('/usr/local/bin/p4')
  end

  spec = {
    :input => "Description: Generated by Puppet VCSrepo\nRoot: /tmp/vcsrepo\n\nView:\n",
    :marshal => false
  }

  describe 'creating' do
    context 'with source and revision' do
      it "should execute 'p4 sync' with the revision" do
        resource[:source] = 'something'
        resource[:revision] = '1'
        ENV['P4CLIENT'] = 'client_ws1'
          
        provider.expects(:p4).with(['client', '-o', 'client_ws1']).returns({})
        provider.expects(:p4).with(['client', '-i'], spec)
        provider.expects(:p4).with(['sync', resource.value(:source) + "@" + resource.value(:revision)])
        provider.create
      end
    end

    context 'without revision' do
      it "should just execute 'p4 sync' without a revision" do
        resource[:source] = 'something'
        ENV['P4CLIENT'] = 'client_ws2'
        
        provider.expects(:p4).with(['client', '-o', 'client_ws2']).returns({})
        provider.expects(:p4).with(['client', '-i'], spec)
        provider.expects(:p4).with(['sync', resource.value(:source)])
        provider.create
      end
    end

    context "when a client and source are not given" do
      it "should execute 'p4 client'" do
        ENV['P4CLIENT'] = nil
        
        path = resource.value(:path)
    	host = Facter.value('hostname')
        default = "puppet-" + Digest::MD5.hexdigest(path + host)
    
        provider.expects(:p4).with(['client', '-o', default]).returns({})
        provider.expects(:p4).with(['client', '-i'], spec)
        provider.create
      end
    end
  end

  describe 'destroying' do
    it "it should remove the directory" do
      ENV['P4CLIENT'] = 'test_client'
      
      provider.expects(:p4).with(['client', '-d', '-f', 'test_client'])
      expects_rm_rf
      provider.destroy
    end
  end

  describe "checking existence" do
    it "should check for the directory" do
      provider.expects(:p4).with(['info'], {:marshal => false}).returns({})
      provider.expects(:p4).with(['where', resource.value(:path) + "..."], {:raise => false}).returns({})
      provider.exists?
    end
  end

end