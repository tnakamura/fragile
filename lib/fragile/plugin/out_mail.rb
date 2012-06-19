# coding: utf-8
require "date"
require "securerandom"
require "net/smtp"

module Flagile
  module Plugin
    class MailOutput
      def initialize(config)
        @port = config[:port] || 25
        @helo_domain = config[:helo_domain] || "localhost"
        @smtp = config[:smtp]
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
        Net::SMTP.start(
          @smtp,
          @port,
          @helo_domain,
          @account,
          @password) do |smtp|
          smtp.send_message message, @from, @to
        end
      end
    end
  end
end

