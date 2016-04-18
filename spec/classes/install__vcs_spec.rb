require 'spec_helper'
describe 'jjb::install::vcs' do

  on_supported_os.each do |os, facts|
    context "on #{os} with standard defaults for all parameters on" do
      let(:params) {
        {
          'vcs_info'           => {
            'vcs_path'         => '/opt/vcs_jenkins_job_builder',
            'vcs_ref'          => 'master',
            'vcs_source'       => 'https://git.openstack.org/openstack-infra/jenkins-job-builder.git',
            'vcs_type'         => 'git',
          },
        }
      }

      it { should compile }
      it { should contain_class('jjb::install::vcs') }
      it { should contain_vcsrepo(params['vcs_info']['vcs_path']).with(
        :ensure   => 'present',
        :provider => params['vcs_info']['vcs_type'],
        :source   => params['vcs_info']['vcs_source'],
        :revision => params['vcs_info']['vcs_ref'],
      ) }
    end
  end
end

# vi: ts=2 sw=2 sts=2 et :
