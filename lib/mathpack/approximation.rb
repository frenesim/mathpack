module Mathpack
  module Approximation
    def self.basic_fi(x, power)
      x**power
    end

    def self.approximate_by_polynom(params = {}, &function)
      f = block_given? ? fill_f(params[:x], &function) : params[:f]
      mnk_matrix, mnk_vector = count_mnk_values(params[:x], f, params[:polynom_power])
      Mathpack::SLE.solve(matrix: mnk_matrix, f: mnk_vector).reverse
    end

    def self.scalar_function_composition(first_vect, second_vect, first_power, second_power)
      result = 0.0
      first_vect.each_index do |i|
        result += basic_fi(first_vect[i], first_power) * basic_fi(second_vect[i], second_power)
      end
      result
    end

    def self.count_mnk_values(x, f, polynom_power)
      mnk_matrix = Array.new(polynom_power + 1) { Array.new(polynom_power + 1) }
      mnk_vector = Array.new(polynom_power + 1)
      0.upto(polynom_power) do |i|
        0.upto(polynom_power) do |j|
          mnk_matrix[i][j] = scalar_function_composition(x, x, i, j)
        end
        mnk_vector[i] = scalar_function_composition(x, f, i, 1)
      end
      [mnk_matrix, mnk_vector]
    end

    def self.print_polynom(coefficients)
      polynom = ''
      coefficients.each_index do |i|
        next if coefficients[i] == 0
        if i == 0
          polynom += '-' if coefficients[i] < 0.0
        else
          polynom += coefficients[i] < 0.0 ? ' - ' : ' + '
        end
        polynom += coefficients[i].abs.to_s if coefficients[i].abs != 1 || i == coefficients.length - 1
        polynom += '*' if i != coefficients.length - 1 && coefficients[i].abs != 1
        case i
          when coefficients.length - 1

          when coefficients.length - 2
            polynom += 'x'
          else
            polynom += coefficients.length - i >= 11 ? "x^(#{coefficients.length - 1 - i})" : "x^#{coefficients.length - 1 - i}"
        end
      end
      polynom
    end

    def self.generate_nodes(params = {})
      nodes = []
      i = 0
      loop do
        nodes << params[:from] + i * params[:step]
        i += 1
        break if params[:from] + i * params[:step] > params[:to]
      end
      nodes << params[:to] if nodes.last != params[:to]
      nodes
    end

    def self.fill_f(x, &function)
      x.map { |val| function.call(val) }
    end
  end
end
