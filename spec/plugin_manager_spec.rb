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
    context "when specified a class" do
      before { @manager = TestApp.new }
      subject { @manager.create_plugin(Fragile::Plugin::TestPlugin, {}) }
      its(:class) { should == Fragile::Plugin::TestPlugin }
    end

    context "when specified a class name not existed" do
      before { @manager = TestApp.new }
      subject { lambda { @manager.create_plugin("foo_bar_hoge_fuga", {}) } } 
      it { should raise_error(NameError) }
    end
    
    describe "when specified a class name existed" do
      before { @manager = TestApp.new }
      subject { @manager.create_plugin(:console_output, {}) } 
      its(:class) { should == Fragile::Plugin::ConsoleOutput }
    end
  end
end

