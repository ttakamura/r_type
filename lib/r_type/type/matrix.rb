module RType
  class Matrix < DelegateClass(::Matrix)
    include Helper::MatrixMultiply
    include Helper::Compareable
    include Helper::RObjDelegatable

    DelegateClassMethods = %w(I [] build column_vector columns diagonal empty identity row_vector rows scalar unit zero)

    class << self
      def method_missing name, *args, &block
        if DelegateClassMethods.include? name.to_s
          self.new ::Matrix.send(name, *args, &block)
        else
          super
        end
      end

      def match? robj, type
        type == 'matrix'
      end
    end

    def initialize obj, *args
      case obj
      when ::RObj
        @robj = obj
      when ::Matrix
        @robj = obj.as_r.robj
      else
        @robj = ::Matrix.send(:new, obj, *args).as_r.robj
      end
    end

    def to_ruby mode = ::RSRuby::BASIC_CONVERSION
      rows = super
      ::Matrix.rows(rows.first.is_a?(::Numeric) ? [rows] : rows)
    end

    def inspect
      "RType::#{to_ruby.inspect}"
    end
  end
end

class ::Matrix
  def as_r
    ::RType::R.rbind(*self.to_a)
  end
end
