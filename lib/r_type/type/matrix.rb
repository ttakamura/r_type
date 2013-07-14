module RType
  class Matrix < DelegateClass(::Matrix)
    include Helper::RObjDelegatable
    include Helper::MatrixMultiply
    include Helper::MatrixAccessor

    delegate_constructor ::Matrix, :I, :[], :build, :column_vector, :columns,
                                   :diagonal, :empty, :identity, :row_vector,
                                   :rows, :scalar, :unit, :zero

    def self.match? robj, type
      type == 'matrix'
    end

    def initialize obj, *args
      case obj
      when ::RObj
        self.robj = obj
      when ::Matrix
        self.ruby_obj = obj
      else
        raise "Not supported: #{obj} in RType::Matrix"
      end
    end

    private
    def convert_robj_to_ruby
      if R.mode(self) == 'logical'
        # We can't parse this R-matrix. So, we return robj instead of ruby_obj.
        # TODO: Parse R-matrix that have logical values
        nil
      else
        rows = super
        ::Matrix.rows(rows.first.is_a?(::Numeric) ? [rows] : rows)
      end
    end
  end
end
