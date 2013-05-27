module RType
  module Helper
    module RObjDelegatable
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

      def robj
        @robj
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
end
