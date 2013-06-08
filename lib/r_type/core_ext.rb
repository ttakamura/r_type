Fixnum.class_eval do
  prepend RType::Helper::NumericDelegateR
  prepend RType::Helper::BooleanDelegateR
end

Bignum.class_eval do
  prepend RType::Helper::NumericDelegateR
  prepend RType::Helper::BooleanDelegateR
end

Float.class_eval do
  prepend RType::Helper::NumericDelegateR
  prepend RType::Helper::BooleanDelegateR
end

Array.class_eval do
  prepend RType::Helper::NumericDelegateR
  prepend RType::Helper::BooleanDelegateR
  include RType::Helper::MatrixMultiply
end

::Matrix.class_eval do
  def as_r
    ::RType::R.rbind(*self.to_a)
  end
end
