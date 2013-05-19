require 'spec_helper'

describe RObject::Matrix do
  def robj original_value
    rsruby_obj = double("rsruby::robj (#{original_value})")
    rsruby_obj.stub(:to_ruby).and_return original_value
    rsruby_obj
  end

  let!(:rsruby) { rsruby_stub }
  let(:matrix)  { RObject::Matrix.new robj([[1, 2], [3, 4]]) }
  let(:vector)  { RObject::Vector.new robj([10, 100]) }

  describe 'multiplication' do
    let(:result) { [[7, 10], [15, 22]] }

    context 'robj * robj-matrix' do
      before  { rsruby_func_stub rsruby, '%*%', [matrix, matrix], result }
      subject { matrix * matrix }
      it      { should == result }
    end

    context 'robj * robj-vector' do
      let(:result) { [310, 420] }
      before  { rsruby_func_stub rsruby, '%*%', [matrix, vector], result }
      subject { matrix * vector }
      it      { should == result }
    end

    context 'robj * ruby-obj' do
      let(:result) { [[10, 20], [30, 40]] }
      before  { rsruby_func_stub rsruby, :*, [matrix, 10], result }
      subject { matrix * 10 }
      it      { should == result }
    end

    context 'ruby-obj * robj' do
      let(:result) { [[10, 20], [30, 40]] }
      before  { rsruby_func_stub rsruby, :*, [10, matrix], result }
      subject { 10 * matrix }
      it      { should == result }
    end
  end
end
