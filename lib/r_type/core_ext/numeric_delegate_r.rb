module RType::CoreExt
  module NumericDelegateR
    extend RType::Helper::RObjDelegatable::ClassMethods

    delegate_to_R '+', '-', '/', '**', '^'

    def * val
      if is_robj_matrix?(val)
        if val.respond_to?(:is_robj_matrix_multiply?) && val.is_robj_matrix_multiply? &&
            self.respond_to?(:is_robj_matrix_multiply?) && self.is_robj_matrix_multiply?
          R['%*%'].call(self, val)
        else
          R[:*].call(self, val)
        end
      else
        super
      end
    end
  end
end
