module RType::CoreExt
  module BooleanDelegateR
    extend RType::Helper::RObjDelegatable::ClassMethods

    delegate_to_R '=~' => '=='
    delegate_to_R '>', '<', '>=', '<=', '|', '&'
  end
end
