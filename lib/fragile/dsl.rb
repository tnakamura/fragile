# coding: utf-8

module Fragile
  module DSL
    def pipeline(name, &block)
      Fragile.application.define_pipeline(name, &block)
    end
  end
end

self.extend Fragile::DSL

