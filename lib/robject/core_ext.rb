Fixnum.class_eval do
  prepend RObject::Helper::NumericDelegateR
end

Bignum.class_eval do
  prepend RObject::Helper::NumericDelegateR
end

Float.class_eval do
  prepend RObject::Helper::NumericDelegateR
end
