module Mathpack
  class Statistics
    attr_accessor :series

    def intitialize(series)
      @series = series
    end

    def number
      @series.length
    end
  end
end
