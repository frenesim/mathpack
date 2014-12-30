module Mathpack
  module Equation
    def self.solve(param = {}, &function)
      derivate_eps = 1e-5
      xk1 = param[:start]
      loop do
        xk = xk1
        xk1 = xk - function.call(xk)/((function.call(xk + derivate_eps) - function.call(xk - derivate_eps))/(2*derivate_eps))
        break if (xk1 - xk).abs < param[:eps]
      end
      return xk1
    end
  end
end
