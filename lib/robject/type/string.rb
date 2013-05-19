module RObject
  class String < Base
    def self.match? robj, type
      type == 'character'
    end
  end
end
