module Mathpack
  module IntegralEquations
    def self.solve_fredholm_2(params = {})
      step = (params[:to] - params[:from]) / 2.0
      y_next = solve_freedholm_with_step(step, params)
      loop do
        y_prev = y_next
        step /= 2.0
        y_next = solve_freedholm_with_step(step, params)
        break if Mathpack::IO.count_diff(y_next, y_prev) / (2**4 - 1) <= params[:eps]
      end
      { x: Mathpack::Approximation.generate_nodes(from: params[:from], to: params[:to], step: step), f: y_next }
    end

    def self.solve_freedholm_with_step(step, params = {})
      nodes = Mathpack::Approximation.generate_nodes(from: params[:from], to: params[:to], step: step)
      a = Array.new(nodes.length) do |i|
        i % 2 == 1 ? 4.0 * step / 3.0 : 2.0 * step / 3.0
      end
      a[0], a[-1] = 1.0 / 3.0 * step, 1.0 / 3.0 * step
      matrix = Array.new(nodes.length) { Array.new nodes.length }
      for i in 0...matrix.length do
        for j in 0...matrix[i].length do
          matrix[i][j] = i == j ? 1.0 - params[:lambda] * a[i] * params[:k].call(nodes[i], nodes[i]) : - params[:lambda] * a[j] * params[:k].call(nodes[i], nodes[j])
        end
      end
      f = Array.new(nodes.length){ |i| params[:f].call(nodes[i]) }
      Mathpack::SLE.solve(matrix: matrix, f: f)
    end

    def self.solve_volter_2(params = {})
      step = (params[:to] - params[:from]) / 2.0
      y_next = solve_volter_with_step(step, params)
      loop do
        y_prev = y_next
        step /= 2.0
        y_next = solve_volter_with_step(step, params)
        break if Mathpack::IO.count_diff(y_next, y_prev) / (2**2 - 1) <= params[:eps]
      end
      { x: Mathpack::Approximation.generate_nodes(from: params[:from], to: params[:to], step: step), f: y_next }
    end

    def self.solve_volter_with_step(step, params = {})
      y = []
      nodes = Mathpack::Approximation.generate_nodes(from: params[:from], to: params[:to], step: step)
      y[0] = params[:f].call(nodes[0])
      y[1] = (params[:f].call(nodes[1]) + 0.5 * params[:lambda] * step * params[:k].call(nodes[1], nodes[0]) * y[0]) / (1.0 - 0.5 * params[:lambda] * step * params[:k].call(nodes[1], nodes[1]))
      for i in 2...nodes.length do
        sum = 0.0
        for j in 1..(i-1) do
          sum += params[:k].call(nodes[i], nodes[j]) * y[j]
        end
        sum *= step
        y[i] = (0.5 * params[:lambda] * step * params[:k].call(nodes[i], nodes[0]) * y[0] + params[:lambda] * sum + params[:f].call(nodes[i])) / (1.0 - 0.5 * params[:lambda] * step * params[:k].call(nodes[i], nodes[i]))
      end
      y
    end
  end
end
