module Mathpack
  class Sample < Statistics

    def initialize(series)
      super(series)
      @sample = true
    end

    def variance
      super / (@sample ? ((number - 1) / number) : 1)
    end

    def standard_deviation
      Math.sqrt(variance)
    end

  end
end