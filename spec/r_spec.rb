require 'spec_helper'

describe RType::R do
  describe '#lazy_expression' do
    before { @exp = RType::R.lazy_expression('function(x) x * 10') }

    it 'should be a R function' do
      @exp.call(3.0).to_ruby.should == 30
    end
  end

  describe '#method_missing' do
    context 'call a RSRuby method' do
      subject { RType::R.eval_R '11 + 44' }
      it      { should == 55 }
    end

    context 'call a R-function' do
      subject { RType::R.sum 11, 22 }
      it      { should == 33 }
    end

    context 'assign a value to R-variable' do
      before  { RType::R.x = 100 }
      subject { RType::R.x }
      it      { should == 100 }
    end

    context 'get a R-variable' do
      before  { RType::R.eval_R 'y = 900' }
      subject { RType::R.y }
      it      { should == 900 }
    end
  end
end

describe ::R do
  it { should == RType::R }

  describe 'R::Matrix' do
    subject { ::R::Matrix }
    it      { should == ::RType::Matrix }
  end

  describe 'R::List' do
    subject { ::R::List }
    it      { should == ::RType::List }
  end

  describe 'R::Vector' do
    subject { ::R::Vector }
    it      { should == ::RType::Vector }
  end
end
