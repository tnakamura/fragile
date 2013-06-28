# coding: utf-8
require "spec_helper"
require "fragile/plugin/direct_input"

describe Fragile::Plugin::DirectInput do
  describe "#initialize" do
    context "config を省略したとき" do
      it "@data に空の配列が格納されるべき" do
        @input = described_class.new
        expect(@input.data).to be_empty
      end
    end

    context "data を含まない config を渡したとき" do
      it "@data に空の配列が格納されるべき" do
        @input = described_class.new({ :test => ["foo"] })
        expect(@input.data).to be_empty
      end
    end

    context "data を含んでいる config を渡したとき" do
      it "@data に config の data が格納されるべき" do
        @input = described_class.new(data: ["http://tnakamura.hatenablog.com"])
        expect(@input.data.size).to eq(1)
        expect(@input.data[0]).to eq("http://tnakamura.hatenablog.com")
      end
    end
  end

  describe "#call" do
    it "initialize に渡した config の data を返すべき" do
      @input = described_class.new(data: ["http://tnakamura.hatenablog.com"])
      @data = @input.call
      expect(@data.size).to eq(1)
      expect(@data[0]).to eq("http://tnakamura.hatenablog.com")
    end
  end
end

