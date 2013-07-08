# coding: utf-8
require_relative "../spec_helper"
require "fragile/plugin/sort_filter"

describe Fragile::Plugin::SortFilter do
  describe "#initialize" do
    context "option を省略したとき" do
      it "@proc が nil であるべき" do
        @filter = described_class.new
        expect(@filter.proc).to be_nil
      end
    end

    context "option で proc を指定したとき" do
      it "@proc に proc が設定されているべき" do
        @filter = described_class.new(:proc => ->(x, y){ x <=> y })
        expect(@filter.proc).to_not be_nil
      end
    end

    context "option で proc を指定しなかったとき" do
      it "@proc が nil であるべき" do
        @filter = described_class.new(:name => "foo")
        expect(@filter.proc).to be_nil
      end
    end
  end

  describe "#call" do
    context "@proc が設定されているとき" do
      it "data をソートした結果を返す" do
        @filter = described_class.new(:proc => ->(x, y){ x <=> y })
        result = @filter.call([2, 1, 5, 3, 4])
        expect(result).to eq([1, 2, 3, 4, 5])
      end
    end

    context "@proc が設定されていないとき" do
      it "data をそのまま返す" do
        data = [2, 1, 5, 3, 4]
        @filter = described_class.new
        result = @filter.call(data)
        expect(result).to eq(data)
      end
    end
  end
end

