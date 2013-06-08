require 'spec_helper'

describe RType::Helper::NumericDelegateR do
  let(:num)    { 100 }
  let(:matrix) { RType::Matrix[[1, 3], [2, 4]] }

  describe '+' do
    subject { num + matrix }
    it      { should == RType::Matrix[[101, 103], [102, 104]] }
  end

  describe '-' do
    subject { num - matrix }
    it      { should == RType::Matrix[[99, 97], [98, 96]] }
  end

  describe '/' do
    let(:num) { 12 }
    subject { num / matrix }
    it      { should == RType::Matrix[[12.0, 4.0], [6.0, 3.0]] }
  end

  describe '*' do
    subject { num * matrix }
    it      { should == RType::Matrix[[100, 300], [200, 400]] }
  end
end
