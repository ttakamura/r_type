require 'spec_helper'

describe RObject::Base do
  let!(:rsruby)    { rsruby_stub }

  def robject original_value
    rsruby_obj = double("rsruby::robj (#{original_value})")
    rsruby_obj.stub(:to_ruby).and_return original_value
    RObject::Base.new rsruby_obj
  end

  context 'robject([1, 2, 3])' do
    subject { robject([1,2,3]) }

    it { should be_include 3 }
    it { should == [1,2,3] }

    its(:to_ruby) { should == [1,2,3] }
    its(:inspect) { should == '[1, 2, 3]' }
  end

  describe 'auto conversion' do
    describe 'R-object receive a method' do
      subject { robject([5,6]) }
      it      { should == [5,6] }
      it      { should be_include 5 }
    end

    describe 'Ruby-object receive a method with R-object' do
      subject { [5,6].include? robject(5) }
      it      { should be_true }
    end
  end

  describe '#method_missing' do
    shared_examples_for 'call a R-function' do |name, right_val, response|
      before do
        func = double("R-function")
        func.should_receive(:call).with(obj.robj, right_val).and_return response
        rsruby.should_receive(:[]).with(name).and_return func
      end
      it { should == response }
    end

    context 'robject([1,2,3])' do
      let(:obj) { robject([1,2,3]) }

      describe '+ 100' do
        subject { obj + 100 }
        it_behaves_like 'call a R-function', '+', 100, [101, 102, 103]
      end

      describe '- 100' do
        subject { obj - 100 }
        it_behaves_like 'call a R-function', '-', 100, [-99, -98, -97]
      end

      describe '* 100' do
        subject { obj * 100 }
        it_behaves_like 'call a R-function', '*', 100, [100, 200, 300]
      end
    end

    context 'call a Ruby-method' do
      subject    { robject(999) }
      its(:to_s) { should == '999' }
    end
  end
end
