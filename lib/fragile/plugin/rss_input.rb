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
        urls = rss.items.map{|item| item.link}
        data + urls
      end
    end
  end
end

