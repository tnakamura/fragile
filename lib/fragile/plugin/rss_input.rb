# coding: utf-8
require "rss"

module Fragile
  module Plugin
    class RssInput
      module FeedItemNormalizer
        def title
          super.content
        rescue
          super
        end

        def link 
          super.href
        rescue
          super
        end
      end

      def initialize(config)
        @url = config[:url]
      end

      def call(data=[])
        rss = RSS::Parser.parse(@url)
        urls = rss.items.map do |item|
          item.extend FeedItemNormalizer
          { :title => item.title, :link => item.link }
        end
        data + urls
      end
    end
  end
end

