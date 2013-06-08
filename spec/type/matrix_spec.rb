require 'spec_helper'

describe RType::Matrix do
  let(:matrix)  { RType::R.matrix [1, 2, 3, 4], ncol: 2 }
  let(:vector)  { RType::R.c [10, 100] }

  subject { matrix }

  its(:to_ruby) { should == Matrix[[1, 3], [2, 4]] }

  it 'should auto-convert between R and Ruby' do
    matrix = subject
    matrix.to_ruby.should == Matrix[[1, 3], [2, 4]]
    matrix = matrix * 2
    matrix.to_ruby.should == Matrix[[2, 6], [4, 8]]
    matrix = matrix + 10
    matrix.to_ruby.should == Matrix[[12, 16], [14, 18]]
  end

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

    context 'robj + ruby-number' do
      subject { matrix + 10 }
      it      { should == Matrix.rows([[11, 13], [12, 14]]) }
    end

    context 'ruby-number + robj' do
      subject { 10 + matrix }
      it      { should == Matrix.rows([[11, 13], [12, 14]]) }
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

  describe '#=~' do
    subject { matrix =~ 3 }

    it 'Matrix[[false, true], [false, false]]' do
      subject[1, 1].should be_false
      subject[1, 2].should be_true
      subject[2, 1].should be_false
      subject[2, 2].should be_false
    end
  end

  describe '#<' do
    subject { matrix < 4 }

    it 'Matrix[[true, true], [true, false]]' do
      subject[1, 1].should be_true
      subject[1, 2].should be_true
      subject[2, 1].should be_true
      subject[2, 2].should be_false
    end
  end

  describe 'ClassMethods' do
    describe '.I' do
      subject { RType::Matrix.I 3 }
      it      { should == RType::Matrix[[1,0,0], [0,1,0], [0,0,1]] }
    end

    describe '.zero' do
      subject { RType::Matrix.zero 3 }
      it      { should == RType::Matrix[[0,0,0], [0,0,0], [0,0,0]] }
    end

    describe '.rows' do
      subject { RType::Matrix.rows [[1,2], [3,4]] }
      it      { should == RType::Matrix[[1,2], [3,4]] }
    end

    describe '.columns' do
      subject { RType::Matrix.columns [[1,2], [3,4]] }
      it      { should == RType::Matrix[[1,3], [2,4]] }
    end
  end

  describe '#[] accessor' do
    context '[1, 2]' do
      subject { matrix[1, 2] }
      it      { should == 3  }
    end

    context '[2, 1]' do
      subject { matrix[2, 1] }
      it      { should == 2  }
    end

    context '[nil, 1]' do
      subject { matrix[nil, 1]   }
      it      { should == [1, 2] }
    end

    context '[2, nil]' do
      subject { matrix[2, nil]   }
      it      { should == [2, 4] }
    end

    context '[ Matrix[[true, false], [false, true]] ]' do
      subject { matrix[ RType::Matrix[[true, false], [false, true]] ] }
      it      { should ==  [1, 4] }
    end

    context '[ Matrix[[true, false], [false, true]] ] = 10' do
      before  { matrix[ RType::Matrix[[true, false], [false, true]] ] = 10 }
      subject { matrix }
      it      { should ==  RType::Matrix[[10, 3], [2, 10]] }
    end
  end
end

describe ::Matrix do
  subject { ::Matrix.rows [[1,3], [2,4]] }

  its(:as_r) { should == RType::R.matrix([1,2,3,4], ncol: 2) }
  its('as_r.to_ruby') { should == subject }
end
