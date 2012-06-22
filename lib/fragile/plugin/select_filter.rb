# coding: utf-8

module Fragile
  module Plugin
    class SelectFilter
      def initialize(config)
        @proc = config[:proc]
      end

      def call(data)
        data.select do |v|
          @proc.call(v)
        end
      end
    end
  end
end

