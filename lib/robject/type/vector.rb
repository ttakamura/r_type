module RObject
  class Vector < Base
    def self.match? robj, type
      (type == 'numeric' || type == 'integer') &&
        Convert.call_R_without_convert(:length, robj) > 1
    end
  end
end
