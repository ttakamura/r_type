module RType::CoreExt
  module DelegateChecker
    def is_robj_matrix? val
      val.is_a?(RType::Vector) || val.is_a?(RType::Matrix)
    end

    def can_delegate_to_R? *args
      is_robj_matrix? args.first
    end
  end
end
