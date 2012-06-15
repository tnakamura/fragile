module Fragile
  module Plugin
    class Bar
      def initialize(config)
        @suffix = config[:suffix]
      end

      def call(data)
        data[:name] += @suffix
        data
      end
    end
  end
end
