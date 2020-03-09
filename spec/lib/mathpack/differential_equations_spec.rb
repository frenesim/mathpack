describe 'DifferentialEquation' do
  require 'mathpack/differential_equations'

  describe '#solve_cauchie_system' do
    let(:eps) { 1e-6 }

    it 'solves cauchie system correctly' do
      cauchie_problem = [ ->(x, u1, u2) { u2 }, -> (x, u1, u2) { - 1.0 / x  * u2 + 1.0 / x**2 * u1 + 3.0 }]
      result = Mathpack::DifferentialEquations.solve_cauchie_system(from: 1.0, to: 2.0, eps: eps, system: cauchie_problem, y0: [1.0, 1.0])
      correct_result = Mathpack::Approximation.fill_f(result[:x]){ |t| t**2 - 0.5 * t + 1.0/(2.0 * t) }
      expect(Mathpack::IO.count_diff(result[:u1], correct_result) <= eps).to eq(true)
    end
  end
end
