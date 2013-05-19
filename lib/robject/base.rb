# -*- coding: utf-8 -*-
module RObject
  class Base < DelegateClass(RObj)
    attr_reader :robj

    class << self
      def convert robj
        self.new robj
      end

      def delegate_to_R from_to
        from_to.each do |from, to|
          define_method(from) do |*args|
            R[to].call @robj, *args
          end
        end
      end
    end

    delegate_to_R '=~' => '==',
                  '**' => '%*%',
                  'is_data_frame?' => 'is_data_frame',
                  'is_list?'       => 'is_list'

    def initialize robj
      @robj = robj
      super robj
    end

    def method_missing name, *args, &block
      if name =~ /^[\-+*\/!><&|\^]+$/
        R[name.to_s].call @robj, *args
      else
        super
      end
    end

    def __getobj__
      to_ruby
    end

    def as_r
      @robj.as_r
    end

    def to_ruby mode = ::RSRuby::BASIC_CONVERSION
      @robj.to_ruby mode
    end

    def is_function?
      R.rsruby.is_function(@robj).to_ruby
    end
  end
end
