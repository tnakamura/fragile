# coding: utf-8
require_relative "test_helper"

class TestApp
  include Fragile::PipelineManager
end

class TestPlugin
  def initialize(config)
    @config = config
  end

  def call(data)
    @config[:called] = true
  end
end

describe "PipelineManager" do
  describe "#define_pipeline" do
    before do
      @manager = TestApp.new
    end

    it "パイプラインを登録できるべき" do
      @manager.define_pipeline :foo do;end
      assert_equal true, @manager.pipelines.has_key?("foo")
    end
  end

  describe "#pipeline_exist?" do
    describe "存在しないパイプライン名のとき" do
      before do
        @manager = TestApp.new
      end

      it "false を返すべき" do
        assert_equal false, @manager.pipeline_exist?("foo")
      end
    end

    describe "存在するパイプライン名のとき" do
      before do
        @manager = TestApp.new
        @manager.define_pipeline "bar" do;end
      end

      it "true を返すべき" do
        assert_equal true, @manager.pipeline_exist?("bar")
      end
    end
  end

  describe "#pipelines" do
    describe "パイプラインが登録されていないとき" do
      before do
        @manager = TestApp.new
      end

      it "空であるべき" do
        assert_equal true, @manager.pipelines.empty?
      end
    end
  end

  describe "#run_pipeline" do
    describe "登録されていないパイプラインを指定したとき" do
      before do
        @manager = TestApp.new
      end

      it "PipelineError が発生するべき" do
        assert_raises Fragile::PipelineError do
          @manager.run_pipeline("hoge")
        end
      end
    end

    describe "登録されているパイプラインを指定したとき" do
      before do
        @config = config = {}
        @manager = TestApp.new
        @manager.define_pipeline "hoge" do
          use TestPlugin, config
        end
      end

      it "パイプラインを実行できるべき" do
        @manager.run_pipeline("hoge")
        assert_equal true, @config[:called]
      end
    end
  end
end

