require 'spec_helper'

describe RType::Helper::RObjDelegatable do
  let(:klass) do
    Class.new(Delegator) do
      include RType::Helper::RObjDelegatable

      def initialize robj=nil, ruby_obj=nil
        if robj
          @robj = robj
        else
          @ruby_obj = ruby_obj
        end
      end
    end
  end
  let(:ruby_obj) { double("ruby_obj") }
  let(:robj)     { double("robj") }
  let(:r_stub)   { double("R") }

  before do
    robj.stub(:to_ruby).with(RSRuby::BASIC_CONVERSION).and_return ruby_obj
    robj.stub(:as_r).and_return robj
    ruby_obj.stub_chain(:as_r, :robj).and_return robj
  end

  context 'has R-obj' do
    subject { klass.new robj, nil }

    its(:ruby_obj) { should == ruby_obj }
    its(:robj)     { should == robj }
    its(:as_r)     { should == robj }
    its(:to_ruby)  { should == ruby_obj }
    its(:inspect)  { should =~ /RType::.*robj/ }

    it 'delegate a method to R' do
      R.stub(:[]).with('+') { r_stub }
      r_stub.stub(:call).with(subject, 100).and_return 150
      expect(subject + 100).to be_eql 150
    end

    it 'delegate a method to Ruby' do
      ruby_obj.should_receive(:hoge).and_return 'Hello world'
      expect(subject.hoge).to be_eql 'Hello world'
    end
  end

  context 'has Ruby-obj' do
    subject { klass.new nil, ruby_obj }

    its(:ruby_obj) { should == ruby_obj }
    its(:robj)     { should == robj }
    its(:as_r)     { should == robj }
    its(:to_ruby)  { should == ruby_obj }
    its(:inspect)  { should =~ /RType::.*ruby_obj/ }

    it 'delegate a method to R' do
      R.stub(:[]).with('+') { r_stub }
      r_stub.stub(:call).with(subject, 100).and_return 150
      expect(subject + 100).to be_eql 150
    end

    it 'delegate a method to Ruby' do
      ruby_obj.should_receive(:hoge).and_return 'Hello world'
      expect(subject.hoge).to be_eql 'Hello world'
    end
  end
end
