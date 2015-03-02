module Mathpack
  module Integration
    STEP = 0.0625
    INTEGRATION_LIMIT = 1e3

    def self.integrate(params = {}, &f)
      if params[:from] == -Float::INFINITY && params[:to] == Float::INFINITY
        result = solve_oi(-INTEGRATION_LIMIT, INTEGRATION_LIMIT, &f)
        g = ->(x) { f.call(-x) }
        result += solve_ni_1(INTEGRATION_LIMIT, &g)
        result += solve_ni_1(INTEGRATION_LIMIT, &f)
      elsif params[:to] == Float::INFINITY || params[:from] == -Float::INFINITY
        if params[:from] == -Float::INFINITY
          params[:from] = -params[:to]
          g = ->(x) { f.call(-x) }
        else
          g = f
        end
        result = solve_ni_1(params[:from], &g)
      else
        result = solve_oi(params[:from], params[:to], &f)
      end
      result
    end

    def self.basic_integrate(a, b, &f)
      result = 5.0/9.0 * f.call((a + b)/2.0 + (b - a)/2.0 * (-(3.0/5.0)**0.5))
      result += 8.0/9.0 * f.call((a + b)/2.0)
      result += 5.0/9.0 * f.call((a + b)/2.0 + (b - a)/2.0 * (3.0/5.0)**0.5)
      result * (b - a)/2.0
    end

    def self.solve_oi(from, to, &f)
      result = 0.0
      nodes = Mathpack::Approximation.generate_nodes(start: from, end: to, step: STEP)
      for i in 0...nodes.length - 1  do
        result += basic_integrate(nodes[i], nodes[i + 1], &f)
      end
      result
    end

    def self.solve_ni_1(from, &f)
      to = [from, INTEGRATION_LIMIT].max
      result = solve_oi(from, to, &f)
      coefficients_array = [0.4589646740, 0.4170008308, 0.1133733821, 0.0103991974, 0.0002610172, 0.0000008985]
      nodes_array = [0.2228466042, 1.8889321017, 2.9927363261, 5.7751435691, 9.8374674184, 15.9828739806]
      nodes_array.each_index do |i|
        result += coefficients_array[i] * Math.exp(nodes_array[i]) * f.call(to + nodes_array[i])
      end
      result
    end
  end
end
