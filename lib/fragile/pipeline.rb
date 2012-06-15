# coding: utf-8

module Fragile
  class PipelineError < Exception
  end

  class Pipeline
    attr_reader :name

    def initialize(name)
      @name = name
      @retry_count = 3
      @plugins = []
    end

    def retry_count(count)
      @retry_count = count
    end

    def use(plugin, config={})
      @plugins << Fragile.application.create_plugin(plugin, config)
    end

    def run
      data = nil
      @plugins.each do |plugin|
        retry_handler do
          data = plugin.call(data)
        end
      end
    end

    private
    def retry_handler(&block)
      count = 0
      begin
        block.call
      rescue
        if @retry_count < count
          raise PipelineError.new("retry over error.")
        end
        count += 1
        retry
      end
    end
  end
end
