# coding: utf-8
require_relative "test_helper"

class TestApp
  include Fragile::PluginManager
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
  describe "#create_plugin" do
    describe "クラスを指定したとき" do
      before do
        @manager = TestApp.new
      end

      it "プラグインのインスタンスを生成できるべき" do
        obj = @manager.create_plugin(Fragile::Plugin::TestPlugin, {})
        assert_equal Fragile::Plugin::TestPlugin, obj.class
      end
    end

    describe "存在しないプラグイン名を指定したとき" do
      before do
        @manager = TestApp.new
      end

      it "NameError が発生するべき" do
        assert_raises NameError do
          @manager.create_plugin("foo_bar_hoge_fuga", {})
        end
      end
    end
    
    describe "存在するプラグイン名を指定したとき" do
      before do
        @manager = TestApp.new
        require "fragile/plugin/console_output"
      end

      it "プラグインのインスタンスを生成できるべき" do
        obj = @manager.create_plugin(:console_output, {})
        assert_equal Fragile::Plugin::ConsoleOutput, obj.class
      end
    end
  end
end

