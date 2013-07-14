require 'spec_helper'

describe RType::DataFrame do
  let(:data) do
    RType::DataFrame.new('age' => [11, 12, 13], 'height' => [170, 173, 174])
  end

  subject { data }

  its(:keys) { should == ['age', 'height'] }

  describe '[]' do
    describe '["age"]' do
      subject { data[:age].ruby_obj }
      it      { should == {'age' => [11, 12, 13]} }
    end

    describe '[1, "age"]' do
      subject { data[1, :age] }
      it      { should == 11 }
    end

    describe '[1, ]' do
      subject { data[3, nil].ruby_obj }
      it      { should == {'age' => 13, 'height' => 174} }
    end
  end

  describe 'keys=' do
    before  { data.keys = ['AA', 'BB'] }
    subject { data }
    its(:keys) { should == ['AA', 'BB'] }
  end
end
