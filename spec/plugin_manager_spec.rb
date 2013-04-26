# coding: utf-8
require_relative "spec_helper"
require "fragile/plugin/console_output"

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

describe Fragile::PluginManager do
  describe "#create_plugin" do
    before do
      @manager = TestApp.new
    end

    context "プラグインクラスを指定したとき" do
      it "プラグインクラスのインスタンスを生成できる" do
        @plugin = @manager.create_plugin(Fragile::Plugin::TestPlugin, {})
        expect(@plugin).to be_an_instance_of(Fragile::Plugin::TestPlugin)
      end
    end

    context "存在しないプラグインクラスの名前を指定したとき" do
      it "NameError が発生する" do
        expect {
          @manager.create_plugin("foo_bar_hoge_fuga", {})
        }.to raise_error(NameError)
      end
    end
    
    describe "存在するプラグインクラスの名前を指定したとき" do
      it "プラグインクラスのインスタンスを生成できる" do
        @plugin = @manager.create_plugin(:console_output, {})
        expect(@plugin).to be_an_instance_of(Fragile::Plugin::ConsoleOutput)
      end
    end
  end
end

