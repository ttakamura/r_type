require 'spec_helper'

describe RType::Base do
  context 'c(1,2,3)' do
    subject { R.eval_R("c(1,2,3)") }

    it { should be_include 3 }
    it { should == [1.0, 2.0, 3.0] }

    its(:to_ruby) { should == [1.0, 2.0, 3.0] }
    its('to_ruby.inspect') { should == '[1.0, 2.0, 3.0]' }
  end

  describe 'auto conversion' do
    describe 'R-object receive a method' do
      subject { R.eval_R("c(5,6)") }
      it      { should == [5,6] }
      it      { should be_include 5 }
    end

    describe 'Ruby-object receive a method with R-object' do
      subject { [5,6].include? R.eval_R("6") }
      it      { should be_true }
    end
  end

  describe '#method_missing' do
    context 'c(1,2,3)' do
      let(:obj) { R.eval_R("c(1,2,3)") }

      describe '+ 100' do
        subject { obj + 100 }
        it      { should == [101, 102, 103] }
      end

      describe '- 100' do
        subject { obj - 100 }
        it      { should == [-99, -98, -97] }
      end

      describe '* 100' do
        subject { obj * 100 }
        it      { should == [100, 200, 300] }
      end
    end

    context 'call a Ruby-method' do
      subject    { R.eval_R("999") }
      its(:to_s) { should == '999.0' }
    end
  end
end
