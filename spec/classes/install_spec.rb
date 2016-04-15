require 'spec_helper'
describe 'jjb::install' do

  on_supported_os.each do |os, facts|
    context "on #{os} with defaults for all parameters on" do
      let(:params) {
        {
          'system_install' => true,
        }
      }

      it { should compile }
      it { should contain_class('jjb::install') }
    end
  end
end

# vi: ts=2 sw=2 sts=2 et :
