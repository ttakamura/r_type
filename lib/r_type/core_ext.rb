Fixnum.class_eval do
  prepend RType::Helper::NumericDelegateR
end

Bignum.class_eval do
  prepend RType::Helper::NumericDelegateR
end

Float.class_eval do
  prepend RType::Helper::NumericDelegateR
end

Array.class_eval do
  prepend RType::Helper::NumericDelegateR
  include RType::Helper::MatrixMultiply
end
