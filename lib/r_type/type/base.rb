# -*- coding: utf-8 -*-
module RType
  class Base < DelegateClass(RObj)
    include Helper::RObjDelegatable

    def self.delegate_to_R from_to
      from_to.each do |from, to|
        define_method(from) do |*args|
          R[to].call @robj, *args
        end
      end
    end

    def self.match? robj, type
      true
    end

    delegate_to_R '=~' => '==',
                  '**' => '%*%',
                  'is_data_frame?' => 'is_data_frame',
                  'is_list?'       => 'is_list'

    def initialize robj
      @robj = robj
    end
  end
end
