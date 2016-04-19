require 'spec_helper'
describe 'jjb::config' do
  let(:default_params) {
    {
      'config'         => {},
      'ini_dir'        => '/foo',
      'ini_file'       => '/foo/bar.ini',
      'ini_group'      => 'biz',
      'ini_mode'       => '0440',
      'ini_owner'      => 'baz',
      'manage_ini_dir' => true,
    }
  }

  on_supported_os.each do |os, facts|
    context "on #{os} with good parameters" do
      let(:params) do
        default_params.merge!({})
      end

      it { should compile }
      it { should contain_class('jjb::config') }
      it { should contain_class('jjb::params') }
      it { should contain_file(params['ini_dir']).with(
        :ensure => 'directory',
        :owner  => params['ini_owner'],
        :group  => params['ini_group'],
      ) }

      # config gets merged with the default config to force certain values to
      # always exist
      it { should contain_ini_config(params['ini_file']).with(
        :config        => {
          'jenkins'    => {
            'user'     => 'jobbuilder',
            'password' => 'YOU_NEED_TO_SET_ME!',
            'url'      => 'https://localhost:8080',
          },
        },
        :owner  => params['ini_owner'],
        :group  => params['ini_group'],
      ) }

      it 'should have a merged config' do
        params.merge!({
          'config'          => {
            'extra_section' => {
              'testoption'  => 'testvalue',
            },
          },
        })

        is_expected.to contain_ini_config(params['ini_file']).with(
          :config        => {
            'jenkins'    => {
              'user'     => 'jobbuilder',
              'password' => 'YOU_NEED_TO_SET_ME!',
              'url'      => 'https://localhost:8080',
            },
            'extra_section' => {
              'testoption'  => 'testvalue',
            },
          },
        )
      end

      it 'should not have an ini_dir if manage_ini_dir is false' do
        params.merge!({'manage_ini_dir' => false})
        is_expected.to_not contain_file(params['ini_dir'])
      end
    end
  end
end

# vi: ts=2 sw=2 sts=2 et :
