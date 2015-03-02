module Mathpack
  class Statistics
    def initialize(series)
      @series = series
      @data_set, @frequency = parse_series(series)
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
      central_moment(4) / variance**2 - 3.0
    end

    def max
      @data_set.max
    end

    def min
      @data_set.min
    end

    def raw_moment(power)
      raw_moment = 0.0
      @data_set.each_index do |i|
        raw_moment += @frequency[i] * @data_set[i]**power
      end
      raw_moment / number
    end

    def central_moment(power)
      central_moment = 0.0
      m = mean
      @data_set.each_index do |i|
        central_moment += @frequency[i] * (@data_set[i] - m)**power
      end
      central_moment / number
    end

    def empirical_cdf(x)
      result = 0.0
      @series.each { |val| result += heaviside(x - val) }
      result / number
    end

    def print_empirical_cdf_to_csv(filename)
      step = 0.5 * (max - min) / number
      val = min - step
      File.open(filename, 'w+') do |file|
        while val <= max + step
          file.write("#{val};")
          file.write("#{empirical_cdf(val)}\n")
          val += step
        end
      end
    end

    def empirical_pdf(x)
      h = variance**0.5 * number**(-1.0 / 6)
      result = 0.0
      @series.each { |val| result += (heaviside(x - val + h) - heaviside(x - val - h)) / (2 * h) }
      result / number
    end

    def print_empirical_pdf_to_csv(filename)
      step = 0.5 * (max - min) / number
      val = min - 10 * step
      File.open(filename, 'w+') do |file|
        while val <= max + 10 * step
          file.write("#{val};")
          file.write("#{empirical_pdf(val)}\n")
          val += step
        end
      end
    end

    def trend(params = {})
      numbers = Array.new(number){ |i| i + 1 }
      polynom = Mathpack::Approximation::approximate_by_polynom(x: numbers, f: @series, polynom_power: params[:polynom_power])
      Mathpack::Approximation.print_polynom(polynom)
    end

    private

    def heaviside(x)
      x <= 0 ? 0 : 1
    end

    def parse_series(series)
      data_set = []
      frequency = []
      series.each do |element|
        if data_set.include? element
          frequency[data_set.index(element)] += 1
        else
          data_set << element
          frequency[data_set.index(element)] = 1
        end
      end
      [data_set, frequency]
    end
  end
end
