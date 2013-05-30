module RType
  module Helper
    module RObjDelegatable
      module ClassMethods
        def delegate_to_R *from_to
          from_to_hash = from_to.first.is_a?(Hash) \
                           ? from_to.first         \
                           : from_to.inject({}) {|h,x| h[x] = x; h }

          from_to_hash.each do |from, to|
            define_method(from) do |*args|
              R[to].call self, *args
            end
          end
        end

        def delegate_constructor klass, *methods
          delegate_klass = self

          methods.each do |name|
            self.class.class_eval do
              define_method(name) do |*args, &block|
                delegate_klass.new klass.send(name, *args, &block)
              end
            end
          end
        end
      end
      extend ClassMethods
    end
  end
end
