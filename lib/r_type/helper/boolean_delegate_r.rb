module RType::Helper::BooleanDelegateR
  class << self
    def delegate_to_R *from_to
      from_to_hash = from_to.first.is_a?(Hash) \
                       ? from_to.first         \
                       : from_to.inject({}) {|h,x| h[x] = x; h }

      from_to_hash.each do |from, to|
        define_method(from) do |*args|
          is_robj_matrix?(args.first) ? R[to].call(self, args.first) : super(*args)
        end
      end
    end
  end

  delegate_to_R '=~' => '=='
  delegate_to_R '>', '<', '>=', '<='

  private
  def is_robj_matrix? val
    val.is_a?(RType::Vector) || val.is_a?(RType::Matrix)
  end
end
