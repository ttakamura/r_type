module RType
  class Matrix < Base
    include Helper::MatrixMultiply
    include Helper::AsRubyCompareable

    def self.match? robj, type
      type == 'matrix'
    end

    def to_ruby mode = ::RSRuby::BASIC_CONVERSION
      rows = @robj.to_ruby(mode)
      ::Matrix.rows(rows.first.is_a?(::Numeric) ? [rows] : rows)
    end

    def inspect
      "RType::#{to_ruby.inspect}"
    end
  end
end

class ::Matrix
  def as_r
    ::RType::R.rbind(*self.to_a)
  end
end
