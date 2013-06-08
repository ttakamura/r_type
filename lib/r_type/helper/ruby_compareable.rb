module RType::Helper::RubyCompareable
  def == obj
    if obj.is_a?(RType::Helper::Compareable)
      to_ruby == obj.to_ruby
    else
      super
    end
  end
end
