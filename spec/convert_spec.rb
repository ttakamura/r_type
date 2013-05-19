require 'spec_helper'

describe RObject::Convert do
  let!(:rsruby)   { rsruby_stub }
  let(:converter) { RObject::Convert.new }

  def robj original_value
    rsruby_obj = double("rsruby::robj (#{original_value})")
    rsruby_obj.stub(:to_ruby).and_return original_value
    rsruby_obj
  end

  describe '#convert' do
    let(:length_val) { 0 }

    shared_examples_for 'convert RObj to' do |klass|
      before do
        rsruby.stub(:[]).with(:length).and_return double(call: length_val)
        rsruby.stub(:[]).with(:class).and_return double(call: r_class)
      end
      subject { converter.convert robj(value) }
      it      { should be_a klass }
      it      { should == value }
    end

    context 'DataFrame' do
      let(:value)   { { x: [1,2,3] } }
      let(:r_class) { 'data.frame' }
      it_behaves_like 'convert RObj to', RObject::DataFrame
    end

    context 'Function' do
      let(:value)   { 'R-function' }
      let(:r_class) { 'function' }
      it_behaves_like 'convert RObj to', RObject::Function
    end

    context 'List' do
      let(:value)   { [1, 2, 3] }
      let(:r_class) { 'list' }
      it_behaves_like 'convert RObj to', RObject::List
    end

    context 'Array' do
      let(:value)   { [1, 2, 3] }
      let(:r_class) { 'array' }
      it_behaves_like 'convert RObj to', RObject::Array
    end

    context 'Matrix' do
      let(:value)   { [[1, 2], [3, 4]] }
      let(:r_class) { 'matrix' }
      it_behaves_like 'convert RObj to', RObject::Matrix
    end

    context 'Vector' do
      let(:length_val) { 2 }
      let(:value)   { [1, 2, 3] }
      let(:r_class) { 'numeric' }
      it_behaves_like 'convert RObj to', RObject::Vector
    end

    context 'String' do
      let(:value)   { "hello world" }
      let(:r_class) { 'character' }
      it_behaves_like 'convert RObj to', RObject::String
    end

    context 'Numeric' do
      let(:value)   { 99.0 }
      let(:r_class) { 'numeric' }
      it_behaves_like 'convert RObj to', RObject::Numeric
    end

    context 'Integer' do
      let(:value)   { 31 }
      let(:r_class) { 'integer' }
      it_behaves_like 'convert RObj to', RObject::Integer
    end

    context 'Base' do
      let(:value)   { 100 }
      let(:r_class) { 'unknown' }
      it_behaves_like 'convert RObj to', RObject::Base
    end
  end
end
