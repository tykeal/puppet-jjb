require 'spec_helper'
describe 'jjb' do
  let(:facts) { {
    :fqdn                   => 'my.test.com',
    :ipaddress              => '10.0.0.1',
    :osfamily               => 'RedHat',
    :operatingsystem        => 'CentOS',
    :operatingsystemrelease => '7',
  } }

  #on_supported_os.each do |os, facts|
    context 'with defaults for all parameters' do
    #context "on #{os} with defaults for all parameters on" do
      it { should compile }
      it { should contain_class('jjb') }
      it { should contain_class('jjb::params') }
      it { should contain_anchor('jjb::begin') }
      it { should contain_class('jjb::install') }
      it { should contain_class('jjb::config') }
      it { should contain_anchor('jjb::end') }
    end
  #end
end

# vi: ts=2 sw=2 sts=2 et :
