# coding: utf-8
require_relative "test_helper"
require "minitest/spec"
require "minitest/autorun"
require "fragile"

class TestApp
  include Fragile::PluginManager

  def initialize(plugin_dir)
    @plugin_dir = plugin_dir
  end
end

module Fragile::Plugin
  class TestPlugin
    def initialize(config)
      @config = config
    end

    def call(data)
    end
  end
end

describe "PluginManager" do
  describe "#load_plugins" do
    describe "プラグインディレクトリが存在するとき" do
      before do
        @plugin_dir = File.join(File.dirname(__FILE__), "../examples/plugins")
        @manager = TestApp.new(@plugin_dir)
      end

      it "プラグインをロードできるべき" do
        @manager.load_plugins
        Fragile::Plugin.const_get("Foo")
        pass
      end
    end
  end

  describe "#create_plugin" do
    describe "クラスを指定したとき" do
      before do
        @plugin_dir = File.join(File.dirname(__FILE__), "../examples/plugins")
        @manager = TestApp.new(@plugin_dir)
      end

      it "プラグインのインスタンスを生成できるべき" do
        obj = @manager.create_plugin(Fragile::Plugin::TestPlugin, {})
        assert_equal Fragile::Plugin::TestPlugin, obj.class
      end
    end

    describe "存在しないプラグイン名を指定したとき" do
      before do
        @plugin_dir = File.join(File.dirname(__FILE__), "../examples/plugins")
        @manager = TestApp.new(@plugin_dir)
      end

      it "NameError が発生するべき" do
        assert_raises NameError do
          @manager.create_plugin("foo_bar_hoge_fuga", {})
        end
      end
    end
    
    describe "存在するプラグイン名を指定したとき" do
      before do
        @plugin_dir = File.join(File.dirname(__FILE__), "../examples/plugins")
        @manager = TestApp.new(@plugin_dir)
        @manager.load_plugins
      end

      it "プラグインのインスタンスを生成できるべき" do
        obj = @manager.create_plugin("foo", {})
        assert_equal Fragile::Plugin::Foo, obj.class
      end
    end
    
    describe "プラグインディレクトリが存在しないとき" do
      before do
        @plugin_dir = File.join(File.dirname(__FILE__), "not_exist")
        @manager = TestApp.new(@plugin_dir)
      end

      it "何もしないべき" do
        @manager.load_plugins
        assert_raises NameError do
          Fragile::Plugin.const_get("Foo")
        end
      end
    end
  end
end

