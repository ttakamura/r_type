module RType
  class Convert
    class NotSupportTypeError < Exception; end

    def self.call_R_without_convert func, *args
      original_mode = RSRuby.get_default_mode
      RSRuby.set_default_mode RSRuby::BASIC_CONVERSION
      result = R.rsruby[func].call(*args)
    ensure
      RSRuby.set_default_mode original_mode
      result
    end

    def convert robj
      type = check_R_type robj
      [Function, DataFrame, List, Array, Matrix, String, Vector, Integer, Numeric, Base].each do |klass|
        if klass.match? robj, type
          break klass.new robj
        end
      end
    end

    private
    def check_R_type robj
      Convert.call_R_without_convert :class, robj
    end
  end
end
