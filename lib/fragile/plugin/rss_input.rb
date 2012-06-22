# coding: utf-8
require "rss"

module Fragile
  module Plugin
    class RssInput
      def initialize(config)
        @url = config[:url]
      end

      def call(data=[])
        rss = RSS::Parser.parse(@url)
        urls = rss.items.map do |item|
          { :title => item.title, :link => item.link }
        end
        data + urls
      end
    end
  end
end

