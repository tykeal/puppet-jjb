require 'spec_helper'
describe 'jjb::install' do

  on_supported_os.each do |os, facts|
    context "on #{os} with standard defaults for all parameters on" do
      let(:params) {
        {
          'install_type'       => 'venv',
          'install_via_source' => false,
          'package_name'       => 'foo',
          'package_version'    => 'present',
          'vcs_info'           => {
            'vcs_path'         => '/opt/vcs_jenkins_job_builder',
            'vcs_ref'          => 'master',
            'vcs_source'       => 'https://git.openstack.org/openstack-infra/jenkins-job-builder.git',
            'vcs_type'         => 'git',
          },
          'venv_path'          => '/opt/venv_jenkins_job_builder',
        }
      }

      it { should compile }
      it { should contain_class('jjb::install') }

      # venv installation
      it { should contain_class('jjb::install::pip') }
      it { should_not contain_class('jjb::install::vcs') }

      it "should install into venv via vcs if install-type is 'venv' and install_via_source is true" do
        params.merge!({'install_via_source' => true})
        is_expected.to contain_class('jjb::install::pip').that_requires(
          'Class[jjb::install::vcs]'
        )
        is_expected.to contain_class('jjb::install::vcs')
      end

      # system installation
      it "should install globally if install_type is 'system'" do
        params.merge!({'install_type' => 'system'})
        is_expected.to contain_class('jjb::install::pip')
      end

      it "should install globaly via vcs if install_type is 'system' and install_via_source is true" do
        params.merge!({
          'install_type'       => 'system',
          'install_via_source' => true,
        })
        is_expected.to contain_class('jjb::install::pip').that_requires(
          'Class[jjb::install::vcs]'
        )
        is_expected.to contain_class('jjb::install::vcs')
      end

      # package installation
      it "should install a package if install_type is 'package'" do
        params.merge!({'install_type' => 'package'})
        is_expected.to contain_class('jjb::install::package').with(
          :package_name    => params['package_name'],
          :package_version => params['package_version'],
        )
      end

      it "should not have a vcs repo if install_type is 'package' even if install_via_source is true" do
        params.merge!({
          'install_type'       => 'package',
          'install_via_source' => true,
        })
        is_expected.to contain_class('jjb::install::package')
        is_expected.to_not contain_class('jjb::install::vcs')
      end
    end
  end
end

# vi: ts=2 sw=2 sts=2 et :
