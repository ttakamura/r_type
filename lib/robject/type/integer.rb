module RObject
  class Integer < Numeric
    def self.match? robj, type
      type == 'integer'
    end
  end
end
