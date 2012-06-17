# coding: utf-8
# Name::      Fragile
# Author::    tnakamura <http://d.hatena.ne.jp/griefworker>
# Created::   Jun 15, 2012
# Updated::   Jun 15, 2012
# Copyright:: tnakamura Copyright (c) 2012
# License::   Licensed under the MIT LICENSE.
require "optparse"
require "logger"
require "fragile/version"
require "fragile/pipeline_manager"
require "fragile/plugin_manager"

module Fragile
  class Application
    include Fragile::PipelineManager
    include Fragile::PluginManager

    attr_reader :logger

    def initialize
      @recipe_file = File.join(Dir.pwd, "Spcfile")
      @logger = Logger.new(STDOUT)
      @logger.level = Logger::WARN
    end

    def run
      handle_options
      load_plugins
      load_recipe_file
      run_pipeline(ARGV)
    end

    def load_recipe_file
      load @recipe_file
    end

    def handle_options
      opts = OptionParser.new
      opts.version = Fragile::VERSION
      opts.banner = "fragile [-f RECIPE_FILE] {options} targets..."
      opts.separator ""
      opts.separator "Options are ..."
      opts.on_tail("-h", "--help", "-H", "Display this help message.") do
        puts opts
        exit
      end
      opts.on("-f", "--recipefile=RECIPE_FILE", "Recipe file path") { |v|
        @recipe_file = v
        @plugin_dir ||= File.join(File.dirname(@recipe_file), "plugins")
      }
      opts.on("-p", "--plugindir=plugin_dir", "Plugin directory") { |v| @plugin_dir = v }
      opts.on("-V", "--verbose", "Show detail log") { |v| @logger.level = Logger::DEBUG }
      opts.parse!(ARGV)

      unless 0 < ARGV.count
        puts opts
        exit
      end
    end
  end

  def self.application
    @application ||= Application.new
  end

  def self.logger
    Fragile.application.logger
  end
end

