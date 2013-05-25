require 'spec_helper'

describe RType::Matrix do
  let(:matrix)  { RType::R.matrix [1, 2, 3, 4], ncol: 2 }
  let(:vector)  { RType::R.c [10, 100] }

  describe 'multiplication' do
    context 'robj * robj-matrix' do
      subject { matrix * matrix }
      it      { should == [[7, 15], [10, 22]] }
    end

    context 'robj * robj-vector' do
      subject { matrix * vector }
      it      { should == [[310], [420]] }
    end

    context 'robj * ruby-array' do
      subject { matrix * [100, 10] }
      it      { should == [[130], [240]] }
    end

    context 'ruby-array * robj' do
      subject { [100, 10] * matrix }
      it      { should == [120, 340] }
    end

    context 'robj * ruby-number' do
      subject { matrix * 10 }
      it      { should == [[10, 30], [20, 40]] }
    end

    context 'ruby-number * robj' do
      subject { 10 * matrix }
      it      { should == [[10, 30], [20, 40]] }
    end
  end
end
