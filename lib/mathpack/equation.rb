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

    def self.derivative(xk, &function)
      eps = 1e-5
      (function.call(xk + eps) - function.call(xk - eps)) / (2 * eps)
    end
  end
end
