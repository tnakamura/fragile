#!/usr/bin/env ruby -I ../lib -I lib
# coding: utf-8
require "minitest/spec"
require "minitest/autorun"
require "fragile"

describe "DSL" do
  describe "#pipeline" do
    include Fragile::DSL

    after do
      Fragile.application.pipelines.clear
    end

    it "パイプラインを登録できるべき" do
      pipeline "foo" do;end
      assert_equal true, Fragile.application.pipelines.has_key?("foo")
    end
  end
end

