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
        message = create_mesage(data)
        send_im_kayac(message) if !message.empty?
      end

      private
      def create_mesage(data)
        data.join("\n")
      end

      def send_im_kayac(message)
        uri = URI.parse "#{@base_url}#{@username}"
        sig = @secret_key ? \
          Digest::SHA1.new.update("#{message}#{@secret_key}").to_s : nil

        request = Net::HTTP::Post.new(uri.path)
        request.set_form_data(
          :handler  => @handler,
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

