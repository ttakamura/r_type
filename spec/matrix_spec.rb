require 'spec_helper'

describe RType::Matrix do
  let(:matrix)  { RType::R.matrix [1, 2, 3, 4], ncol: 2 }
  let(:vector)  { RType::R.c [10, 100] }

  subject { matrix }

  its(:to_ruby) { should == Matrix[[1, 3], [2, 4]] }

  describe '#multiplication' do
    context 'robj * robj-matrix' do
      subject { matrix * matrix }
      it      { should == Matrix.rows([[7, 15], [10, 22]]) }
    end

    context 'robj * robj-vector' do
      subject { matrix * vector }
      it      { should == Matrix.rows([[310], [420]]) }
    end

    context 'robj * ruby-array' do
      subject { matrix * [100, 10] }
      it      { should == Matrix.rows([[130], [240]]) }
    end

    context 'ruby-array * robj' do
      subject { [100, 10] * matrix }
      it      { should == Matrix.rows([[120, 340]]) }
    end

    context 'robj * ruby-number' do
      subject { matrix * 10 }
      it      { should == Matrix.rows([[10, 30], [20, 40]]) }
    end

    context 'ruby-number * robj' do
      subject { 10 * matrix }
      it      { should == Matrix.rows([[10, 30], [20, 40]]) }
    end
  end

  describe '#method_missing' do
    before do
      matrix.should_receive(:to_ruby).and_return { double('matrix', hoge: 789) }
    end

    subject { matrix.hoge }

    it 'delegate to ruby Matrix' do
      should == 789
    end
  end
end

describe ::Matrix do
  subject { ::Matrix.rows [[1,3], [2,4]] }

  its(:as_r) { should == RType::R.matrix([1,2,3,4], ncol: 2) }
  its('as_r.to_ruby') { should == subject }
end
