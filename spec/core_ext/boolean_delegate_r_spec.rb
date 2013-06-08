require 'spec_helper'

describe RType::CoreExt::BooleanDelegateR do
  let(:num)    { 3 }
  let(:matrix) { RType::Matrix[[1, 3], [2, 4]] }

  describe '<' do
    subject { num < matrix }

    it 'Matrix[[false, false], [false, true]]' do
      subject[1, 1].should be_false
      subject[1, 2].should be_false
      subject[2, 1].should be_false
      subject[2, 2].should be_true
    end
  end

  describe '>' do
    subject { num > matrix }

    it 'Matrix[[true, false], [true, false]]' do
      subject[1, 1].should be_true
      subject[1, 2].should be_false
      subject[2, 1].should be_true
      subject[2, 2].should be_false
    end
  end

  describe '=~' do
    subject { num =~ matrix }

    it 'Matrix[[false, true], [false, false]]' do
      subject[1, 1].should be_false
      subject[1, 2].should be_true
      subject[2, 1].should be_false
      subject[2, 2].should be_false
    end
  end
end
