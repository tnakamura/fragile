# coding: utf-8

module Fragile
  module Plugin
    # @example
    #   pipeline :sample do
    #     use "direct_input", :data => [2, 1, 4, 3, 5]
    #     use "sort_filter", :proc => ->(x, y){ x <=> y }
    #     use "console_output"
    #   end
    class SortFilter
      attr_reader :proc

      def initialize(options={})
        @proc = options[:proc]
      end

      def call(data)
        if @proc
          data.sort do |x, y|
            @proc.call(x, y)
          end
        else
          data
        end
      end
    end
  end
end

