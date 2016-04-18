require 'spec_helper'
describe 'jjb::install::pip' do

  on_supported_os.each do |os, facts|
    context "on #{os} with standard defaults for all parameters on" do
      let(:params) {
        {
          'install_type'       => 'system',
          'install_via_source' => false,
          'package_name'       => 'foo',
          'package_version'    => 'present',
          'vcs_path'           => '/foo',
          'venv_path'          => '/bar',
        }
      }

      it { should compile }
      it { should contain_class('jjb::install::pip') }
      it { should contain_python__pip(params['package_name']).with(
        :ensure => params['package_version'],
      ) }

      # venv
      it 'should install into a venv if install_type is venv' do
        params.merge!({'install_type' => 'venv'})
        is_expected.to contain_python__pip(params['package_name']).with(
          :ensure     => params['package_version'],
          :virtualenv => params['venv_path'],
        )
      end

      # via source
      it 'should install from a vcs if install_via_source is true' do
        params.merge!({'install_via_source' => true})
        is_expected.to contain_python__pip(params['package_name']).with(
          :ensure    => params['package_version'],
          :url       => params['vcs_path'],
          :subscribe => "Vcsrepo[#{params['vcs_path']}]",
        )
      end
    end
  end
end

# vi: ts=2 sw=2 sts=2 et :
