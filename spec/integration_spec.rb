describe 'Integration' do
  require 'mathpack/integration'

  context 'a-b integrals' do
    it 'should integrate e^(-x^2)' do
      expect(Mathpack::Integration.integrate(from: 0, to: 10){ |x| Math.exp(-x**2) }).to be_between(0.8862269254525, 0.8862269254534)
    end

    it 'should integrate sin(x^2)' do
      expect(Mathpack::Integration.integrate(from: 1, to: 7.3){ |x| Math.sin(x**2) }).to be_between(0.384315, 0.384324)
    end

    it 'should integrate sin(x)/x' do
      expect(Mathpack::Integration.integrate(from: 0, to: 3.6){ |x| Math.sin(x) / x }).to be_between(1.821945, 1.821954)
      expect(Mathpack::Integration.integrate(from: -1, to: 1){ |x| Math.sin(x) / x }).to be_between(1.89216614073435, 1.89216614073444)
    end

    it 'should integrate 1/lnx' do
      expect(Mathpack::Integration.integrate(from: 1.1, to: 4.7){ |x| 1 / Math.log(x) }).to be_between(5.120315, 5.120324)
    end
  end

  context 'ni-1 integrals' do
    it 'should integrate e^(-x)/(x+1)' do
      expect(Mathpack::Integration.integrate(from: 0, to: Float::INFINITY){ |x| Math.exp(-x) / (x + 1) }).to be_between(0.596346, 0.596348)
    end

    it 'should count gamma function' do
      expect(Mathpack::Integration.integrate(from: 0, to: Float::INFINITY){ |x| Math.exp(-x) * x**1.5 }).to be_between(1.329339, 1.329341)
    end

    it 'should count Laplace function' do
      expect(Mathpack::Integration.integrate(from: -Float::INFINITY, to: 1.65){ |x| 1.0 / (2 * Math::PI)**0.5 * Math.exp(-x**2/2) }).to be_between(0.950450, 0.950549)
    end
  end

  context 'ni-2 integrals' do
    it 'should integrate e^(-x^2)*cos(x)' do
      expect(Mathpack::Integration.integrate(from: -Float::INFINITY, to: Float::INFINITY){ |x| Math.exp(-x**2) * Math.cos(x) }).to be_between(1.3803, 1.3804)
    end
  end
end
