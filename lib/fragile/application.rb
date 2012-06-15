# coding: utf-8
# Name::      Fragile
# Author::    tnakamura <http://d.hatena.ne.jp/griefworker>
# Created::   Jun 15, 2012
# Updated::   Jun 15, 2012
# Copyright:: tnakamura Copyright (c) 2012
# License::   Licensed under the MIT LICENSE.
require "optparse"
require "fragile/version"
require "fragile/pipeline_manager"
require "fragile/plugin_manager"

module Fragile
  class Application
    include Fragile::PipelineManager
    include Fragile::PluginManager

    def initialize
      @spcfile = File.join(Dir.pwd, "Spcfile")
    end

    def run
      handle_options
      load_plugins
      load_spcfile
      run_pipeline(ARGV)
    end

    def load_spcfile
      load @spcfile
    end

    def handle_options
      OptionParser.new do |opts|
        opts.version = Fragile::VERSION
        opts.banner = "fragile [-f CONFFILE] {options} targets..."
        opts.separator ""
        opts.separator "Options are ..."
        opts.on_tail("-h", "--help", "-H", "Display this help message.") do
          puts opts
          exit
        end

        opts.on("-f", "--fragfile=spcfile", "Config file path") { |v|
          @spcfile = v
          @plugin_dir ||= File.join(File.dirname(@spcfile), "plugins")
        }
        opts.on("-p", "--plugindir=plugin_dir", "Plugin directory") { |v| @plugin_dir = v }
      end.parse!(ARGV)
    end
  end

  def self.application
    @application ||= Application.new
  end
end

