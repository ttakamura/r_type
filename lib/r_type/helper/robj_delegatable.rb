module RType
  module Helper
    module RObjDelegatable
      extend ClassMethods
      include RType::CoreExt::NumericDelegateR
      include RType::CoreExt::BooleanDelegateR

      delegate_to_R '*'

      def self.included(klass)
        klass.extend ClassMethods
      end

      def __getobj__
        to_ruby
      end

      def robj
        @robj ||= convert_ruby_to_robj.tap do |newobj|
          @ruby_obj = nil unless newobj.nil?
        end
      end

      def ruby_obj
        @ruby_obj ||= convert_robj_to_ruby.tap do |newobj|
          @robj = nil unless newobj.nil?
        end
      end

      def robj= obj
        @ruby_obj = nil
        @robj = obj
      end

      def ruby_obj= obj
        @robj = nil
        @ruby_obj = obj
      end

      def as_r
        robj.as_r
      end

      def to_ruby mode = nil
        ruby_obj
      end

      def inspect
        "RType::#{(@robj || @ruby_obj).inspect}"
      end

      def == obj
        if obj.is_a?(RObjDelegatable)
          self.robj == obj.robj || !!R['identical'].call(self, obj)
        else
          super
        end
      end

      private
      def convert_robj_to_ruby
        @robj.to_ruby(::RSRuby::BASIC_CONVERSION)
      end

      def convert_ruby_to_robj
        if @ruby_obj.respond_to?(:as_r)
          @ruby_obj.as_r.robj
        else
          R.assign('_tmp_var_for_rtype', @ruby_obj).robj
        end
      end

      def can_delegate_to_R? *args
        true
      end
    end
  end
end
