# coding: utf-8

module Fragile
  module Plugin
    class ConsoleOutput
      def initialize(config)
      end

      def call(data)
        data.each do |v|
          puts v
        end
      end
    end
  end
end

