require 'spec_helper'
describe 'jjb::install::package' do

  on_supported_os.each do |os, facts|
    context "on #{os} with standard defaults for all parameters on" do
      let(:params) {
        {
          'package_name'    => 'foo',
          'package_version' => 'present',
        }
      }

      it { should compile }
      it { should contain_class('jjb::install::package') }
      it { should contain_package(params['package_name']).with(
        :ensure => params['package_version'],
      ) }
    end
  end
end

# vi: ts=2 sw=2 sts=2 et :
