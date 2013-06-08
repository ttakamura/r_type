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

    def [] *args
      args = convert_nil_args_to_vector(args)
      R['['].call self, *args
    end

    def []= *args
      if args[0].is_a?(RType::Matrix)
        self.robj = R['[<-'].call(self, args[0], args[1]).robj
      else
        args = convert_nil_args_to_vector(args)
        self.robj = R['[<-'].call(self, *args).robj
      end
    end

    def row_size
      R.nrow(self)
    end

    def column_size
      R.ncol(self)
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

    def convert_nil_args_to_vector args
      args[0] = (1..row_size).to_a    if args[0].nil? && args[1].is_a?(::Numeric)
      args[1] = (1..column_size).to_a if args[1].nil? && args[0].is_a?(::Numeric)
      args
    end
  end
end
