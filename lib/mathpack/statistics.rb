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
      central_moment(3) / variance**1.5
    end

    def kurtosis
      central_moment(4) / variance**2
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

    def empirical_cdf(x)
      result = 0.0
      @series.each{ |val| result += e(x - val) }
      result / number
    end

    def print_empirical_cdf_to_csv(filename)
      step = 0.25
      val = min - step
      File.open(filename, 'w+') do |file|
        while val <= max + step do
          file.write("#{val};")
          file.write("#{empirical_cdf(val)}\n")
          val += step
        end
      end
    end

    def empirical_pdf(x)
      h = variance**0.5 * number**(-1.0/6)
      result = 0.0
      @series.each{ |val| result += (e(x - val + h) - e(x - val - h))/(2*h) }
      result / number
    end

    def print_empirical_pdf_to_csv(filename)
      step = 0.25
      val = min - 2*step
      File.open(filename, 'w+') do |file|
        while val <= max + 2*step do
          file.write("#{val};")
          file.write("#{empirical_pdf(val)}\n")
          val += step
        end
      end
    end

    private

    def e(x)
      x <= 0 ? 0 : 1
    end
  end
end
