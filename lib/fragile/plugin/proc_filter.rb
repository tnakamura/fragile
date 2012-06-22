# coding: utf-8

class ProcFilter
  def initialize(config)
    @proc = config[:proc]
  end

  def call(data)
    data.select do |v|
      @proc.call(v)
    end
  end
end

