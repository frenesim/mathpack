module Mathpack
  module Equation
    def self.solve(params = {}, &function)
      xk1 = params[:start]
      loop do
        xk = xk1
        xk1 = xk - function.call(xk) / derivative(xk, &function)
        break if (xk1 - xk).abs < params[:eps]
      end
      xk1
    end

    def self.solve_system(params = {})
      xk1 = params[:start].dup
      loop do
        xk = xk1.dup
        w_xk = params[:w_matrix].call(*xk, *params[:additional_params])
        f = params[:f].call(*xk, *params[:additional_params])
        delta = Mathpack::SLE.solve(matrix: w_xk, f: invert(f))
        xk1 = plus(xk, delta)
        break if Mathpack::IO.count_diff(xk1, xk) <= params[:eps]
      end
      xk1
    end

    def self.invert(vector)
      vector.map{ |element| -element }
    end

    def self.plus(first_array, second_array)
      Array.new(first_array.length) { |i| first_array[i] + second_array[i] }
    end

    def self.derivative(xk, &function)
      eps = 1e-5
      (function.call(xk + eps) - function.call(xk - eps)) / (2 * eps)
    end
  end
end
