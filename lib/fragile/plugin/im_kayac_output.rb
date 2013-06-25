# coding: utf-8
require "net/http"
require "digest/sha1"

module Fragile
  module Plugin
    class ImKayacOutput
      def initialize(config)
        @base_url   = "http://im.kayac.com/api/post/"
        @username   = config[:username]
        @password   = config[:password]   || nil
        @secret_key = config[:secret_key] || nil
        @handler    = config[:handler]    || nil
      end

      def call(data=[])
        case
        when data.empty?
          # nothing
        when data.all? {|v| v.kind_of?(Hash) && v.key?(:link) && v.key?(:title)}
          data.each do |item|
            send_im_kayac(item[:title], :handler => item[:link])
          end
        else
          message = create_mesage(data)
          send_im_kayac(message)
        end
      end

      private
      def create_mesage(data)
        data.join("\n")
      end

      def send_im_kayac(message, options={})
        uri = URI.parse "#{@base_url}#{@username}"
        handler = options[:handler] || @handler
        sig = @secret_key ? \
          Digest::SHA1.new.update("#{message}#{@secret_key}").to_s : nil

        request = Net::HTTP::Post.new(uri.path)
        request.set_form_data(
          :handler  => handler,
          :password => @password,
          :sig      => sig,
          :message  => message,
        )

        Net::HTTP.new(uri.host, uri.port).start do |http|
          http.request(request)
        end
      end
    end
  end
end

