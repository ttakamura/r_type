module RObject
  class Array < Base
    def self.match? robj, type
      type == 'array'
    end
  end
end
