require 'spec_helper'

describe RType::R do
  let!(:rsruby) { rsruby_stub }

  describe '#lazy_expression' do
    before do
      rsruby.should_receive(:eval_R).with('quote(a + b)') { RType::Base.new nil }
    end

    subject { @expression = RType::R.lazy_expression('a + b') }
    it      { should be_a RType::Base }
  end

  describe '#method_missing' do
    context 'call a RSRuby method' do
      before  { rsruby.should_receive(:eval_R).with('11 + 44').and_return 55 }
      subject { RType::R.eval_R '11 + 44' }
      it      { should == 55 }
    end

    context 'call a R-function' do
      before  { rsruby_func_stub rsruby, :sum, [11, 22], 33 }
      subject { RType::R.sum 11, 22 }
      it      { should == 33 }
    end

    context 'assign a value to R-variable' do
      before do
        rsruby_variable_stub rsruby, :x, 100
        RType::R.x = 100
      end
      subject { RType::R.x }
      it      { should == 100 }
    end

    context 'get a R-variable' do
      before  { rsruby_variable_stub rsruby, :y, 900 }
      subject { RType::R.y }
      it      { should == 900 }
    end
  end
end
