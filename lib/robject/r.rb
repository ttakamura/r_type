module RObject
  module R
    class << self
      def method_missing name, *args, &block
        if name =~ /^(.*)=$/
          rsruby[:assign].call $1.to_s, args.first
        elsif rsruby.respond_to? name
          rsruby.send name, *args
        else
          obj = rsruby[name]
          if obj.is_function?
            obj.call *args
          else
            obj
          end
        end
      end

      def run &block
        instance_eval &block
      end

      def print *args
        rsruby[:print].call *args
      end

      def lazy_expression r_exp
        rsruby.eval_R "quote(#{r_exp})"
      end
      alias_method "`", :lazy_expression

      def rsruby
        @rsruby ||= init_rsruby
      end

      def init_rsruby
        @rsruby = RSRuby.instance
        RSRuby.set_default_mode RSRuby::PROC_CONVERSION

        check   = ->(x) { true }
        convert = ->(x) { RObject::Base.convert x }
        @rsruby.proc_table[check] = convert

        @rsruby
      end

      def reset
        @rsruby = nil
      end
    end
  end
end
