module RType
  class Function < Base
    def self.match? robj, type
      type == 'function' || (type == 'standardGeneric' &&
                             Convert.call_R_without_convert(:is_function, robj))
    end

    private
    def argument_length
      R['length'].call R['formals'].call(self)
    end
  end
end
