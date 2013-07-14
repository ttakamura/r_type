require 'spec_helper'

describe RType::Function do
  context 'with no args' do
    subject { RType::R.mean }
    it      { should be_a RType::Function }
  end

  context 'widh args' do
    subject { RType::R.mean [1,2,3,4] }
    it      { should == 2.5 }
  end
end
