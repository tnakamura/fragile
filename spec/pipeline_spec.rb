# coding: utf-8
require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Fragile::Pipeline do
  describe "#name" do
    before do
      @pipeline = Fragile::Pipeline.new("test")
    end

    it "設定した値を取得できるべき" do
      @pipeline.name.should == "test"
    end
  end

  describe "#retry_count" do
    before do
      @pipeline = Fragile::Pipeline.new("test")
    end

    it "値を設定できるべき" do
      @pipeline.retry_count 5

      actual = nil
      @pipeline.instance_eval { actual = @retry_count }

      actual.should == 5
    end
  end

  describe "#use" do
    class TestPlugin
      attr_accessor :config

      def initialize(config)
        @config = config
      end

      def call(data)
      end
    end

    before do
      @pipeline = Fragile::Pipeline.new("test")
    end

    it "プラグインを設定できるべき" do
      @pipeline.use TestPlugin

      actual_count = nil
      @pipeline.instance_eval { actual_count = @plugins.count }

      actual_count.should == 1
    end
  end

  describe "#run" do
    class TestPlugin
      attr_accessor :config

      def initialize(config)
        @config = config
        @max_error_count = config[:max_error_count] || 0
        @error_count = 0
      end

      def call(data)
        if @error_count < @max_error_count
          @error_count += 1
          raise "Error #{@error_count}"
        end
        @config[:called] = true
      end
    end

    it "パイプラインを実行できるべき" do
      @data = {}
      @pipeline = Fragile::Pipeline.new("test")
      @pipeline.use TestPlugin, @data

      @pipeline.run

      @data[:called].should be_true
    end

    it "@retry_count 回リトライできるべき" do
      @data = {:max_error_count => 3}
      @pipeline = Fragile::Pipeline.new("test")
      @pipeline.use TestPlugin, @data
      @pipeline.retry_count 2

      @pipeline.run

      @data[:called].should be_true
    end

    it "@retry_count 回以上失敗すると PipelineError が発生するべき" do
      @data = {:max_error_count => 4}
      @pipeline = Fragile::Pipeline.new("test")
      @pipeline.use TestPlugin, @data
      @pipeline.retry_count 2

      lambda{ @pipeline.run }.should raise_error(Fragile::PipelineError)
    end
  end
end

