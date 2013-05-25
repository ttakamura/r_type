module RType
  class DataFrame < Base
    def self.match? robj, type
      type == 'data.frame'
    end
  end
end
