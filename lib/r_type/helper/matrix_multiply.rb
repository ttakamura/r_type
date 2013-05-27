module RType::Helper::MatrixMultiply
  def * val
    if val.respond_to?(:is_robj_matrix_multiply?) && val.is_robj_matrix_multiply?
      R['%*%'].call self, val
    else
      super
    end
  end

  def is_robj_matrix_multiply?
    true
  end
end
