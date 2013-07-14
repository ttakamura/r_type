module RType::Helper::MatrixAccessor
  def [] *args
    args = convert_nil_args_to_vector(args)
    R['['].call self, *args
  end

  def []= *args
    if args[0].is_a?(RType::Helper::MatrixAccessor)
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
  def convert_nil_args_to_vector args
    args[0] = (1..row_size).to_a    if args[0].nil? && args[1].is_a?(::Numeric)
    args[1] = (1..column_size).to_a if args[1].nil? && args[0].is_a?(::Numeric)
    args
  end
end
