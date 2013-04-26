# coding: utf-8
require_relative "spec_helper"

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

describe Fragile::PipelineManager do
  describe "#define_pipeline" do
    before do
      @manager = TestApp.new
    end

    it "パイプラインを登録できるべき" do
      @manager.define_pipeline :foo do;end
      expect(@manager.pipelines.has_key?("foo")).to be_true
    end
  end

  describe "#pipeline_exist?" do
    describe "存在しないパイプライン名のとき" do
      before do
        @manager = TestApp.new
      end

      it "false を返すべき" do
        expect(@manager.pipeline_exist?("foo")).to be_false
      end
    end

    describe "存在するパイプライン名のとき" do
      before do
        @manager = TestApp.new
        @manager.define_pipeline "bar" do;end
      end

      it "true を返すべき" do
        expect(@manager.pipeline_exist?("bar")).to be_true
      end
    end
  end

  describe "#pipelines" do
    describe "パイプラインが登録されていないとき" do
      before do
        @manager = TestApp.new
      end

      it "空であるべき" do
        expect(@manager.pipelines).to be_empty
      end
    end
  end

  describe "#run_pipeline" do
    describe "登録されていないパイプラインを指定したとき" do
      before do
        @manager = TestApp.new
      end

      it "PipelineError が発生するべき" do
        expect {
          @manager.run_pipeline("hoge")
        }.to raise_error(Fragile::PipelineError)
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
        expect(@config[:called]).to be_true
      end
    end
  end
end

