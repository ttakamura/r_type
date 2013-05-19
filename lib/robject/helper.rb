module RObject
  module Helper
    module MatrixMultiply
      def * val
        if val.respond_to?(:matrix_multiply?) && val.matrix_multiply?
          R['%*%'].call self, val
        else
          R[:*].call self, val
        end
      end

      def matrix_multiply?
        true
      end
    end

    module NumericDelegateR
      def + val
        val.is_a?(RObject::Base) ? R[:+].call(self, val) : super
      end

      def - val
        val.is_a?(RObject::Base) ? R[:-].call(self, val) : super
      end

      def / val
        val.is_a?(RObject::Base) ? R[:/].call(self, val) : super
      end

      def * val
        val.is_a?(RObject::Base) ? R[:*].call(self, val) : super
      end

      def ** val
        val.is_a?(RObject::Base) ? R[:**].call(self, val) : super
      end
    end
  end
end
