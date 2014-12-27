describe 'Equations' do
  require 'mathpack/equation'

  context "calculated unlinear equations" do

    it 'should solve equation' do
      eps = 0.00001
      expect(Mathpack::Equation.solve(0, eps){|x| x**2 - Math.sin(x+1)}).to be_between(-0.613763 - eps, -0.613763 + eps)
    end
  end
end
