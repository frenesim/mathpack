module Mathpack
  class Statistics
    def initialize(series)
      @series = series
      @data_set, @frequency = parse_series(series)
    end

    def number
      @series.length.to_f
    end
    end

    def mean
      @mean ||= raw_moment(1)
    end

    def variance
      @variance ||= central_moment(2)
    end

    def standard_deviation
      Math.sqrt(variance)
    end

    def skewness
      @skewness ||= central_moment(3) / central_moment(2) ** 1.5
    end

    def kurtosis
      @kurtosis ||= central_moment(4) / central_moment(2) ** 2 - 3.0
    end

    def max
      @data_set.max
    end

    def min
      @data_set.min
    end

    def raw_moment(power)
      raw_moment = 0.0
      @data_set.zip(@frequency).each do |value, frequency|
        raw_moment += frequency * value**power
      end
      raw_moment / number
    end

    def central_moment(power)
      @series.map{ |s| (s - average) }.map{|s| s ** power}.sum / number
    end

    def empirical_cdf(x)
      1.0 / number * @series.count { |value| Mathpack::Functions.heaviside(x - value) > 0 }
    end

    def print_empirical_cdf(filename)
      step = 0.5 * (max - min) / number
      nodes = Mathpack::Approximation.generate_nodes(from: min - step, to: max + step, step: step)
      values = nodes.map { |x| empirical_cdf(x) }
      Mathpack::IO.print_table_function(filename: filename, x: nodes, y: values)
    end

    def empirical_pdf(x)
      h = variance**0.5 * number**(-1.0 / 6)
      1.0 / number * @series.inject(0) { |sum, value| sum + (Mathpack::Functions.heaviside(x - value + h) - Mathpack::Functions.heaviside(x - value - h)) / (2 * h) }
    end

    def print_empirical_pdf(filename)
      step = 0.5 * (max - min) / number
      nodes = Mathpack::Approximation.generate_nodes(from: min - 10 * step, to: max + 10 * step, step: step)
      values = nodes.map { |x| empirical_pdf(x) }
      Mathpack::IO.print_table_function(filename: filename, x: nodes, y: values)
    end

    def trend(params = {})
      numbers = Array.new(number){ |i| i + 1 }
      polynom = Mathpack::Approximation::approximate_by_polynom(x: numbers, f: @series, polynom_power: params[:polynom_power])
      Mathpack::Approximation.print_polynom(polynom)
    end

    private

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
