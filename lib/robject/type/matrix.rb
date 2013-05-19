module RObject
  class Matrix < Base
    def self.match? robj, type
      type == 'matrix'
    end
  end
end
