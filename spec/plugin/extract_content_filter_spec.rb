# coding: utf-8
require "spec_helper"
require "fragile/plugin/extract_content_filter"

describe Fragile::Plugin::ExtractContentFilter do
  describe "#initialize" do
    context "config を省略したとき" do
      it "@uri_key は nil になるべき" do
        @filter = described_class.new
        expect(@filter.uri_key).to be_nil
      end
    end

    context "uri_key を含まない config を渡したとき" do
      it "@uri_key は nil になるべき" do
        @filter = described_class.new(name: "foo")
        expect(@filter.uri_key).to be_nil
      end
    end

    context "uri_key を含んでいる config を渡したとき" do
      it "@uri_key に config の uri_key が格納されるべき" do
        @filter = described_class.new(uri_key: "uri")
        expect(@filter.uri_key).to eq("uri")
      end
    end
  end

  describe "#call" do
    before do
      html = <<-EOS
      <html>
        <head>
          <title>Test</title>
        </head>
        <body>
          <div>
            <h1>Test</h1>
            This is test document.
          </div>
        </body>
      </html>
      EOS

      stub_request(:get, "www.test.com").
        to_return(body: html, status:200)
    end

    context "uri_key を指定したとき" do
      it "URI とタイトルと本文を抽出できるべき" do
        @filter = described_class.new(uri_key: "uri")
        @data = @filter.call([{"uri" => "http://www.test.com"}])
        expect(@data.size).to eq(1)
        expect(@data[0][:title]).to eq("Test")
        expect(@data[0][:uri]).to eq("http://www.test.com")
      end
    end

    context "uri_key を指定していないとき" do
      it "URI とタイトルと本文を抽出できるべき" do
        @filter = described_class.new
        @data = @filter.call(["http://www.test.com"])
        expect(@data.size).to eq(1)
        expect(@data[0][:title]).to eq("Test")
        expect(@data[0][:uri]).to eq("http://www.test.com")
      end
    end
  end
end

