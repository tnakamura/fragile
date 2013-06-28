# coding: utf-8

module Fragile
  module Plugin
    # config で直接パイプラインに流すデータを指定するプラグイン
    #
    # @example
    # require "fragile/plugin/direct_input
    # require "fragile/plugin/console_output
    #
    # pipeline :sample do
    #   use :direct_input, data: ["https://tnakamura.hatenablog.com"]
    #   use :console_output
    # end
    class DirectInput
      attr_reader :data

      def initialize(config={})
        @data = config[:data] || []
      end

      def call(data=[])
        @data
      end
    end
  end
end

