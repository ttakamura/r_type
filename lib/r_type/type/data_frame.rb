module RType
  class DataFrame < Base
    include Helper::MatrixAccessor

    def self.match? robj, type
      type == 'data.frame'
    end

    def initialize obj, *args
      case obj
      when ::RObj
        self.robj = obj
      when ::Hash
        self.ruby_obj = obj
      else
        raise "Not supported: #{obj} in RType::DataFrame"
      end
    end

    def keys= new_keys
      self.robj = R['colnames<-'].call(self, new_keys).robj
    end

    private
    def convert_ruby_to_robj
      R.as_data_frame(x: stringfy_ruby_obj).robj
    end

    def stringfy_ruby_obj
      @ruby_obj.tap do |hash|
        hash.keys.each do |key|
          hash[key.to_s] = hash.delete(key)
        end
      end
    end
  end
end
