require 'spec_helper'

describe 'Symbol' do
  describe 'as_r' do
    subject { :name }

    its(:as_r) { should == 'name' }
  end
end

describe 'Range' do
  describe 'as_r' do
    subject { 3..7 }

    its(:as_r) { should == [3, 4, 5, 6, 7] }
  end
end
