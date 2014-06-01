# coding: utf-8
require "open-uri"
require_relative "extractcontent"

module Fragile
  module Plugin
    # @example
    # require "fragile/contrib/extract_content_filter"
    #
    # pipeline "sample" do
    #   use "extract_content_filter", uri_key: "uri"
    # end
    class ExtractContentFilter
      attr_reader :uri_key

      def initialize(config={})
        @uri_key = config[:uri_key]
      end

      def call(data=[])
        data.map do |item|
          if @uri_key
            uri = item[@uri_key]
          else
            uri = item
          end

          content = ""
          title = ""
          open(uri) do |io|
            html = io.read
            content, title = ExtractContent.analyse(html)
          end

          # タイトルと URI と本文を返す
          { title: title, uri: uri,  content: content }
        end
      end
    end
  end
end

