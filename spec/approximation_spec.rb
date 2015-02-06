describe 'Approximation' do
  require 'mathpack/approximation'

  context '#mnk' do
    let(:x_start) { 0.0 }
    let(:x_end) { 10.0 }
    let(:step) { 0.25 }
    let(:nodes) { Mathpack::Approximation.generate_nodes(start: x_start, end: x_end, step: step) }
    let(:values) { Mathpack::Approximation.fill_f(nodes){ |val| val**2 } }

    it 'should generate nodes' do
      expect(nodes.length).to eq(41)
      expect(nodes.first).to eq(x_start)
      expect(nodes.last).to eq(x_end)
    end

    it 'should generate correct nodes' do
      nodes = Mathpack::Approximation.generate_nodes(start: 0, end: 1, step: 0.001)
      expect(nodes.last).to eq(1.0)
    end

    it 'should fill function table' do
      expect(values.length).to eq(nodes.length)
      expect(values.last).to eq(nodes.last**2)
    end

    it 'should print polynoms' do
      expect(Mathpack::Approximation.print_polynom([5])).to eq('5')
      expect(Mathpack::Approximation.print_polynom([2, 3])).to eq('2*x + 3')
      expect(Mathpack::Approximation.print_polynom([1, -1, 1])).to eq('x^2 - x + 1')
      expect(Mathpack::Approximation.print_polynom([1, 3, 5])).to eq('x^2 + 3*x + 5')
      expect(Mathpack::Approximation.print_polynom([1, -2, 3, -4])).to eq('x^3 - 2*x^2 + 3*x - 4')
      expect(Mathpack::Approximation.print_polynom([1, 0, 1])).to eq('x^2 + 1')
    end

    it 'should approximate by polynom' do
      coefficients = Mathpack::Approximation.approximate_by_polynom(x: nodes, f: values, polynom_power: 2)
      expect(coefficients).to eq([1.0, 0.0, 0.0])
      coefficients = Mathpack::Approximation.approximate_by_polynom(x: nodes, f: values, polynom_power: 0)
      expect(coefficients).to eq([33.75])
    end
  end
end
