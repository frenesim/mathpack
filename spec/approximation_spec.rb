describe 'Approximation' do
  require 'mathpack/approximation'

  context '#mnk' do
    let(:x_start) { 0.0 }
    let(:x_end) { 10.0 }
    let(:step) { 0.25 }
    let(:nodes) { Mathpack::Approximation.generate_nodes(start: x_start, end: x_end, step: step) }
    let(:values) { Mathpack::Approximation.fill_f(nodes){ |val| val**2 } }

    it 'should generate nodes' do
      expect(nodes.length).to be_eql(41)
      expect(nodes.first).to be_eql(x_start)
      expect(nodes.last).to be_eql(x_end)
    end

    it 'should fill function table' do
      expect(values.length).to be_eql(nodes.length)
      expect(values.last).to be_eql(nodes.last**2)
    end

    it 'should print polynoms' do
      expect(Mathpack::Approximation.print_polynom([5])).to be_eql('5')
      expect(Mathpack::Approximation.print_polynom([2, 3])).to be_eql('2*x + 3')
      expect(Mathpack::Approximation.print_polynom([1, -1, 1])).to be_eql('x^2 - x + 1')
      expect(Mathpack::Approximation.print_polynom([1, 3, 5])).to be_eql('x^2 + 3*x + 5')
      expect(Mathpack::Approximation.print_polynom([1, -2, 3, -4])).to be_eql('x^3 - 2*x^2 + 3*x - 4')
      expect(Mathpack::Approximation.print_polynom([1, 0, 1])).to be_eql('x^2 + 1')
    end

    it 'should approximate by polynom' do
      coefficients = Mathpack::Approximation.approximate_by_polynom(x: nodes, f: values, polynom_power: 2)
      expect(coefficients).to be_eql([1.0, 0.0, 0.0])
      coefficients = Mathpack::Approximation.approximate_by_polynom(x: nodes, f: values, polynom_power: 0)
      expect(coefficients).to be_eql([33.75])
    end
  end
end
