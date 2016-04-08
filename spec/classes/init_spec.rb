require 'spec_helper'
describe 'mscs' do

  context 'with defaults for all parameters' do
    it { should contain_class('mscs') }
  end
end
