module RType
  class Matrix < Base
    include Helper::MatrixMultiply

    def self.match? robj, type
      type == 'matrix'
    end
  end
end
