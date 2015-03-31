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
      @series.each { |val| result += Mathpack::Functions.heaviside(x - val) }
      result / number
    end

    def print_empirical_cdf_to_csv(filename)
      step = 0.5 * (max - min) / number
      nodes = Mathpack::Approximation.generate_nodes(from: min - step, to: max + step, step: step)
      values = nodes.map { |x| empirical_cdf(x) }
      Mathpack::IO.print_table_function(filename: filename, x: nodes, y: values)
    end

    def empirical_pdf(x)
      h = variance**0.5 * number**(-1.0 / 6)
      result = 0.0
      @series.each { |val| result += (Mathpack::Functions.heaviside(x - val + h) - Mathpack::Functions.heaviside(x - val - h)) / (2 * h) }
      result / number
    end

    def print_empirical_pdf_to_csv(filename)
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
