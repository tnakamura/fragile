# coding: utf-8
require "fragile/plugin/rss_input"
require "fragile/plugin/select_filter"
require "fragile/plugin/console_output"

pipeline :sample do
  retry_count 4

  use :rss_input, :url => "http://d.hatena.ne.jp/griefworker/rss"
  use :select_filter, :proc => lambda{|x| x[:title].include?("[Ruby]")}
  use :console_output
end

