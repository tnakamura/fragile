module Fragile
  module Plugin
    class Foo
      def initialize(config)
        @name = config[:name]
      end

      def call(data)
        { :name => @name }
      end
    end
  end
end

