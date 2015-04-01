describe 'Equation' do
  require 'mathpack/equation'

  describe '#solve' do
    let(:eps) { 0.00001 }

    it 'solves nonlinear equations correctly' do
      expect(Mathpack::Equation.solve(start: 0, eps: eps) { |x| x**2 - Math.sin(x + 1) }).to be_between(-0.613763 - eps, -0.613763 + eps)
      expect(Mathpack::Equation.solve(start: 0.01, eps: eps) { |x| 1 / x - Math.log(x) }).to be_between(1.76322 - eps, 1.76322 + eps)
      expect(Mathpack::Equation.solve(start: 0.01, eps: eps) { |x| x**2 - 2 * x + 1 }).to be_between(1.0 - eps, 1.0 + eps)
      expect(Mathpack::Equation.solve(start: 0.01, eps: eps) { |x| Math.exp(x - 2) - Math.sin(x) }).to be_between(0.159396 - eps, 0.159396 + eps)
    end
  end

  describe '#solve_system' do
    it 'solves system of nonlinear equations correctly' do
      f = -> x, y { [x + y - 3.0, x**2 + y**2 - 9.0] }
      w = -> x, y { [[1, 1], [2 * x, 2 * y]] }
      solution = Mathpack::Equation.solve_system(start: [1, 5], eps: 1e-4, f: f, w_matrix: w)
      expect(Mathpack::IO.count_diff(solution, [0, 3]) <= 1e-4).to eq(true)
    end
  end
end
