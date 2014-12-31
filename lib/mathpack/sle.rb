require 'matrix'

module Mathpack
  module SLE
    EPS = 1e-14

    def self.solve(params)
      type = params[:f].class
      @matrix = params[:matrix].to_a
      @f = params[:f].to_a.flatten
      @number = @f.length
      @x = Array.new(@number) { |i| i + 1 }
      unless solve_direct()
        raise 'SLE can\'t be solved'
      end
      if type == Matrix
        return Matrix.row_vector(solve_reverse())
      else
        return solve_reverse()
      end
    end

    def self.swap_lines(first_line, second_line)
      0.upto(@number - 1) do |j|
        @matrix[first_line][j], @matrix[second_line][j] = @matrix[second_line][j], @matrix[first_line][j]
      end
      @f[first_line], @f[second_line] = @f[second_line], @f[first_line]
    end

    def self.swap_columns(first_column, second_column)
      0.upto(@number - 1) do |i|
        @matrix[i][first_column], @matrix[i][second_column] = @matrix[i][second_column], @matrix[i][first_column]
      end
      @x[first_column], @x[second_column] = @x[second_column], @x[first_column]
    end

    def self.make_null_column(step)
      (step + 1).upto(@number - 1) do |i|
        alpha = -@matrix[i][step]/@matrix[step][step].to_f
        step.upto(@number - 1) do |j|
          @matrix[i][j] += @matrix[step][j]*alpha
        end
        @f[i] += @f[step]*alpha
      end
    end

    def self.solve_direct
      0.upto(@number - 1) do |i|
        maximum = 0.0
        max_line = i
        max_column = i
        i.upto(@number - 1) do |line|
          i.upto(@number - 1) do |column|
            maximum, max_line, max_column = @matrix[line][column].abs, line, column if @matrix[line][column].abs > maximum
          end
        end
        return false if maximum < EPS
        swap_lines(i, max_line) if (max_line != i)
        swap_columns(i, max_column) if (max_column != i)
        make_null_column(i)
      end
      return true
    end

    def self.solve_reverse
      result_vector = Array.new(@number)
      (@number - 1).downto(0) do |i|
        if i == (@number - 1)
          result_vector[@x[i] - 1] = @f[i]/@matrix[i][i]
        else
          sum = 0.0
          for j in (i + 1)...@number do
            sum += @matrix[i][j]*result_vector[@x[j]-1]
          end
          result_vector[@x[i] - 1] = (@f[i] - sum)/@matrix[i][i]
        end
      end
      return result_vector
    end
  end
end
