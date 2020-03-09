describe 'Functional' do
  require 'mathpack/functional'

  describe '#derivative' do
    it 'calculates nth derivative' do
      expect(Mathpack::Functional.derivative(2) { |x| x**3 }.(1)).to eq(6.0)
    end
  end
end
