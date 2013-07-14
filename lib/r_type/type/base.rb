# -*- coding: utf-8 -*-
module RType
  class Base < DelegateClass(RObj)
    include Helper::RObjDelegatable

    def self.match? robj, type
      true
    end

    def initialize robj
      self.robj = robj
    end
  end
end
