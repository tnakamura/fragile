# coding: utf-8
# Name::      Fragile
# Author::    tnakamura <http://d.hatena.ne.jp/griefworker>
# Created::   Jun 15, 2012
# Updated::   Jun 15, 2012
# Copyright:: tnakamura Copyright (c) 2012
# License::   Licensed under the MIT LICENSE.

module Fragile
  module DSL
    def pipeline(name, &block)
      Fragile.application.define_pipeline(name, &block)
    end
  end
end

self.extend Fragile::DSL

