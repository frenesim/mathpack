module Mathpack
  class Statistics
    def initialize(series)
      @series = series
    end

    def number
      @series.length
    end

    def mean
      raw_moment(1)
    end

    def variance
      central_moment(2)
    end

    def skewness
      central_moment(3) /= variance**1.5
    end

    def kurtosis
      central_moment(4) / variance ** 2 - 3
    end

    def max
      @series.max
    end

    def min
      @series.min
    end

    def raw_moment(power)
      raw_moment = 0.0
      @series.each{ |x| raw_moment += x**power }
      raw_moment / number
    end

    def central_moment(power)
      central_moment = 0.0
      m = mean
      @series.each{ |x| central_moment += (x - m)**power }
      central_moment / number
    end
  end
end
