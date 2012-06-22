# coding: utf-8

module Fragile
  module Plugin
    class MapFilter
      def initialize(config)
        @proc = config[:proc]
      end

      def call(data)
        data.map do |v|
          @proc.call(v)
        end
      end
    end
  end
end

