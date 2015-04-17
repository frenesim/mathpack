describe 'IntegralEquation' do
  require 'mathpack/integral_equations'

  describe '#solve_fredholm_2' do
    let(:eps) { 1e-5 }

    it 'solves fredholm 2 equations correctly' do
      k = -> x, t { 1.0 / (x + t**2)**0.5 }
      f = -> x { 2*x + (x + 1)**0.5 - (x + 4)**0.5 }
      result = Mathpack::IntegralEquations.solve_fredholm_2(from: 1, to: 2, lambda: 0.5, eps: eps, k: k, f: f)[:f]
      solution = Mathpack::Approximation.fill_f(Mathpack::Approximation.generate_nodes(from: 1, to: 2, step: 1.0 / (result.count - 1))) { |x| 2*x }
      expect(Mathpack::IO.count_diff(result, solution) <= eps).to eq(true)
    end
  end

  describe '#solve_volter_2' do
    let(:eps) { 1e-5 }

    it 'solves volter 2 equations correctly' do
      k_volter = -> x, t { Math.cos(x - t) }
      f_volter = -> x { 0.75 * Math.exp(x) + 0.25 * Math.cos(x) - 0.25 * Math.sin(x) }
      result = Mathpack::IntegralEquations.solve_volter_2(from: 0, to: 1, lambda: 0.5, eps: eps, k: k_volter, f: f_volter)[:f]
      solution = Mathpack::Approximation.fill_f(Mathpack::Approximation.generate_nodes(from: 0, to: 1, step: 1.0 / (result.count - 1))) { |x| Math.exp(x) }
      expect(Mathpack::IO.count_diff(result, solution) <= eps).to eq(true)
    end
  end
end
