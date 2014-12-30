describe 'Equations' do
  require 'mathpack/equation'

  context '#solve nonlinear equations' do
    let(:eps) { 0.00001 }

    it 'should give correct results' do
      expect(Mathpack::Equation.solve(start: 0, eps: eps){|x| x**2 - Math.sin(x+1)}).to be_between(-0.613763 - eps, -0.613763 + eps)
      expect(Mathpack::Equation.solve(start: 0.01, eps: eps){|x| 1/x - Math.log(x)}).to be_between(1.76322 - eps, 1.76322 + eps)
      expect(Mathpack::Equation.solve(start: 0.01, eps: eps){|x| x**2 - 2*x + 1}).to    be_between(1.0 - eps, 1.0 + eps)
      expect(Mathpack::Equation.solve(start: 0.01, eps: eps){|x| Math.exp(x-2) - Math.sin(x)}).to    be_between(0.159396 - eps, 0.159396 + eps)
    end
  end
end
