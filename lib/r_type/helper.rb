module RType
  module Helper
    module MatrixMultiply
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

    module NumericDelegateR
      def + val
        is_robj_matrix?(val) ? R[:+].call(self, val) : super
      end

      def - val
        is_robj_matrix?(val) ? R[:-].call(self, val) : super
      end

      def / val
        is_robj_matrix?(val) ? R[:/].call(self, val) : super
      end

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

      def ** val
        is_robj_matrix?(val) ? R[:**].call(self, val) : super
      end

      private
      def is_robj_matrix? val
        val.is_a?(RType::Vector) || val.is_a?(RType::Matrix)
      end
    end

    module AsRubyCompareable
      def == obj
        if obj.is_a?(AsRubyCompareable)
          to_ruby == obj.to_ruby
        else
          super
        end
      end
    end
  end
end
