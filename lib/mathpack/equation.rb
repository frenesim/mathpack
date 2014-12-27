module Mathpack
  module Equation
    def self.solve(start, eps, &function)
      derivate_eps = eps**2
      xk1 = start
      loop do
        xk = xk1
        xk1 = xk - function.call(xk)/((function.call(xk + derivate_eps) - function.call(xk))/derivate_eps)
        break if (xk1 - xk).abs < eps
      end
      return xk1
    end
  end
end
