Fixnum.class_eval do
  prepend RType::CoreExt::NumericDelegateR
  prepend RType::CoreExt::BooleanDelegateR
  prepend RType::CoreExt::DelegateChecker
end

Bignum.class_eval do
  prepend RType::CoreExt::NumericDelegateR
  prepend RType::CoreExt::BooleanDelegateR
  prepend RType::CoreExt::DelegateChecker
end

Float.class_eval do
  prepend RType::CoreExt::NumericDelegateR
  prepend RType::CoreExt::BooleanDelegateR
  prepend RType::CoreExt::DelegateChecker
end

Array.class_eval do
  prepend RType::CoreExt::NumericDelegateR
  prepend RType::CoreExt::BooleanDelegateR
  prepend RType::CoreExt::DelegateChecker
  include RType::Helper::MatrixMultiply
end

::Matrix.class_eval do
  def as_r
    ::RType::R.rbind(*self.to_a)
  end
end

::Symbol.class_eval do
  def as_r
    to_s
  end
end

::Range.class_eval do
  def as_r
    to_a
  end
end
