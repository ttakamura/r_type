module RType
  module R
    class << self
      def method_missing name, *args, &block
        if name =~ /^(.*)=$/
          rsruby[:assign].call $1.to_s, args.first
        elsif rsruby.respond_to? name
          rsruby.send name, *args
        else
          obj = rsruby[name]
          if obj.is_a?(::RType::Function) && args.length > 0
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
        RSRuby.set_default_mode RSRuby::PROC_CONVERSION
        converter = RType::Convert.new
        @rsruby = RSRuby.instance
        @rsruby.proc_table[->(x){ true }] = ->(x) { converter.convert x }
        @rsruby
      end

      private
      def reset
        @rsruby = nil
      end
    end
  end
end
