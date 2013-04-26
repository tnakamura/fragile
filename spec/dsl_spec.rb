# coding: utf-8
require_relative "spec_helper"

describe Fragile::DSL do
  describe "#pipeline" do
    include Fragile::DSL

    after do
      Fragile.application.pipelines.clear
    end

    it "パイプラインを登録できるべき" do
      pipeline "foo" do;end
      expect(Fragile.application.pipelines.has_key?("foo")).to be_true
    end
  end
end
