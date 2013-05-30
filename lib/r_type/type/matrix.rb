module RType
  class Matrix < DelegateClass(::Matrix)
    include Helper::RObjDelegatable
    include Helper::MatrixMultiply
    include Helper::Compareable

    delegate_constructor ::Matrix, :I, :[], :build, :column_vector, :columns,
                                   :diagonal, :empty, :identity, :row_vector,
                                   :rows, :scalar, :unit, :zero

    def self.match? robj, type
      type == 'matrix'
    end

    def initialize obj, *args
      case obj
      when ::RObj
        @robj = obj
      when ::Matrix
        @ruby_obj = obj
      else
        raise "Not supported: #{obj} in RType::Matrix"
      end
    end

    private
    def convert_robj_to_ruby
      rows = super
      ::Matrix.rows(rows.first.is_a?(::Numeric) ? [rows] : rows)
    end
  end
end
