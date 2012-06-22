# coding: utf-8
require "date"
require "securerandom"
require "net/smtp"

module Fragile
  module Plugin
    class MailOutput
      def initialize(config)
        @port = config[:port] || 25
        @helo_domain = config[:helo_domain] || "localhost"
        @auth_type = config[:auth_type] || :plain
        @smtp = config[:smtp]
        @ssl = config[:ssl] || true
        @account = config[:account]
        @password = config[:password]
        @from = config[:from]
        @to = config[:to]
        @subject = config[:subject]
      end

      def call(data=[])
        message = create_mesage(data)
        send_mail(message)
      end

      private
      def create_mesage(data)
        message = <<-EOM
From: <#{@from}>
To: <#{@to}>
Subject: #{@subject}
Date: #{Date.today}
Message-Id: #{SecureRandom.uuid}@localhost

        EOM
        message += data.join("\n")
      end

      def send_mail(message)
        @smtp = Net::SMTP.new(@smtp, @port)
        @smtp.enable_starttls if @ssl
        @smtp.start(@helo_domain, @account, @password, @auth_type) do |smtp|
          smtp.send_message(message, @from, @to)
        end
      end
    end
  end
end

