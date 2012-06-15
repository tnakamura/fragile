# coding: utf-8
# Name::      Fragile
# Author::    tnakamura <http://d.hatena.ne.jp/griefworker>
# Created::   Jun 15, 2012
# Updated::   Jun 15, 2012
# Copyright:: tnakamura Copyright (c) 2012
# License::   Licensed under the MIT LICENSE.

module Fragile
  module Plugin; end

  class PluginError < Exception
  end

  module PluginManager
    attr_accessor :plugin_dir

    def load_plugins
      return unless Dir.exist?(@plugin_dir)

      pattern = File.join(@plugin_dir, "*.rb")
      Dir.glob(pattern) do |path|
        load path
      end
    end

    def create_plugin(plugin, config)
      if plugin.instance_of?(Class)
        # クラスなら直接 new する
        plugin.new(config)
      else
        # 文字列かシンボルならクラスを取得して new する
        plugin_name = classify(plugin.to_s)
        create_plugin_instance(plugin_name, config)
      end
    end

    private
    def create_plugin_instance(class_name, config)
      klass = Fragile::Plugin.const_get(class_name)
      klass.new(config)
    end

    def classify(name)
      name.split("_").map{ |s| s.capitalize }.join
    end
  end
end

