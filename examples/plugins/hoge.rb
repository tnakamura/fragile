module Fragile
  module Plugin
    class Hoge 
      def initialize(config)
      end

      def call(data)
        puts data[:name]
      end
    end
  end
end

