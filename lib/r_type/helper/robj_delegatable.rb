module RType
  module Helper
    module RObjDelegatable
      def self.included(klass)
        klass.extend ClassMethods
      end

      module ClassMethods
        def delegate_to_R *from_to
          case from_to.first
          when ::Hash
            from_to.first.each do |from, to|
              define_method(from) do |*args|
                R[to].call self, *args
              end
            end
          else
            from_to.each do |name|
              define_method(name) do |*args|
                R[name].call self, *args
              end
            end
          end
        end
      end
      extend ClassMethods

      delegate_to_R '=~' => '=='
      delegate_to_R '+', '*', '-', '/', '>', '<', '>=', '<=', '|', '&', '^'

      def __getobj__
        to_ruby
      end

      def robj
        @robj
      end

      def as_r
        robj.as_r
      end

      def to_ruby mode = ::RSRuby::BASIC_CONVERSION
        @ruby_obj ||= @robj.to_ruby mode
      end

      def inspect
        "RType::#{to_ruby.inspect}"
      end
    end
  end
end
