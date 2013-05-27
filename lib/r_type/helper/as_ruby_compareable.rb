module RType::Helper::AsRubyCompareable
  def == obj
    if obj.is_a?(RType::Helper::AsRubyCompareable)
      to_ruby == obj.to_ruby
    else
      super
    end
  end
end
