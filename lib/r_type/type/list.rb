module RType
  class List < Base
    def self.match? robj, type
      type == 'list'
    end
  end
end
