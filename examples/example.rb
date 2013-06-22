# coding: utf-8
require "fragile/plugin/rss_input"
require "fragile/plugin/select_filter"
require "fragile/plugin/map_filter"
require "fragile/plugin/console_output"
require "fragile/plugin/mail_output"
require "fragile/plugin/im_kayac_output"

pipeline :console_sample do
  retry_count 4

  use :rss_input, :url => "http://d.hatena.ne.jp/griefworker/rss"
  use :select_filter, :proc => lambda{|x| x[:title].include?("[Ruby]")}
  use :map_filter, :proc => lambda{|x| x[:title] = x[:title].encode("UTF-8")}
  use :console_output
end

pipeline :mail_sample do
  retry_count 4

  use :rss_input, :url => "http://d.hatena.ne.jp/griefworker/rss"
  use :select_filter, :proc => lambda{|x| x[:title].include?("[Ruby]")}
  use :mail_output, {
    :port => 587,
    :helo_domain => "gmail.com",
    :auth_type => :login,
    :smtp => "smtp.gmail.com",
    :account => "yourname@gmail.com",
    :password => "password",
    :from => "from@example.com",
    :to => "to@example.com"
  }
end

pipeline :im_kayac_sample do
  retry_count 4

  use :rss_input, :url => "http://d.hatena.ne.jp/griefworker/rss"
  use :select_filter, :proc => lambda{|x| x[:title].include?("[Ruby]")}
  use :map_filter, :proc => lambda{|x| x[:title] = x[:title].encode("UTF-8")}
  use :im_kayac_output, {
    :secret_key => "your-secret-key",
    :handler  => "http://d.hatena.ne.jp/griefworker",
    :username => "your-username",
  }
end

