require 'mathpack'

module Mathpack
  module DifferentialEquations
    def self.runge_kutta_4(params = {})
      nodes = Mathpack::Approximation.generate_nodes(from: params[:from], to: params[:to], step: params[:step])
      y = Array.new(params[:system].length) { Array.new(nodes.length) }
      y.each_index do |i|
        y[i][0] = params[:y0][i]
      end
      fi0 = Array.new(y.length)
      fi1 = Array.new(y.length)
      fi2 = Array.new(y.length)
      fi3 = Array.new(y.length)
      for i in 0...nodes.length-1 do
        column = y.transpose[i]
        y_volna = Array.new(y.length)
        y.each_index do |j|
          fi0[j] = params[:system][j].call(nodes[i], *column)
        end
        y.each_index do |j|
          y_volna.each_index { |k| y_volna[k] = column[k] + 0.5 * params[:step] * fi0[k] }
          fi1[j] = params[:system][j].call(nodes[i] + 0.5 * params[:step], *y_volna)
        end
        y.each_index do |j|
          y_volna.each_index { |k| y_volna[k] = column[k] + 0.5 * params[:step] * fi1[k] }
          fi2[j] = params[:system][j].call(nodes[i] + 0.5 * params[:step], *y_volna)
        end
        y.each_index do |j|
          y_volna.each_index { |k| y_volna[k] = column[k] + params[:step] * fi2[k] }
          fi3[j] = params[:system][j].call(nodes[i + 1], *y_volna)
        end
        y.each_index do |j|
          y[j][i + 1] = y[j][i] + params[:step]/6.0 * (fi0[j] + 2.0 * fi1[j] + 2.0 * fi2[j] + fi3[j])
          y[j][i + 1] = y[j][i] + params[:step]/6.0 * (fi0[j] + 2.0 * fi1[j] + 2.0 * fi2[j] + fi3[j])
        end
      end
      y
    end

    def self.solve_cauchie_system(params = {})
      params[:method] ||= :runge_kutta_4
      params[:m] = 2
      step = (params[:to] - params[:from]) / 2.0
      result = Mathpack::DifferentialEquations.send(params[:method], from: params[:from], to: params[:to], step: step, y0: params[:y0], system: params[:system], eps: params[:eps])
      u_next = Array.new(params[:system].length) { |i| result[i] }
      loop do
        u_prev = Array.new(u_next.length) { |i| u_next[i].dup }
        step /= 2.0
        result = Mathpack::DifferentialEquations.send(params[:method], from: params[:from], to: params[:to], step: step, y0: params[:y0], system: params[:system], eps: params[:eps])
        u_next.each_index do |i|
          u_next[i] = result[i]
        end
        is_finished = true
        u_next.each_index do |i|
          if Mathpack::IO.count_diff(u_next[i], u_prev[i]) / (2**params[:m] - 1) > params[:eps]
            is_finished = false
            break
          end
        end
        break if is_finished
      end
      generate_result(params, step, u_next)
    end

    def self.generate_result(params, step, u)
      result = { x: Mathpack::Approximation.generate_nodes(from: params[:from], to: params[:to], step: step) }
      u.each_index { |i| result[:"u#{i + 1}"] = u[i] }
      result
    end
  end
end
