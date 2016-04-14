require 'spec_helper'
describe 'jjb' do

  context 'with defaults for all parameters' do
    it { should contain_class('jjb') }
  end
end
