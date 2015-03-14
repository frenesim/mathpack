describe 'Functions' do
  require 'mathpack/functions'

  describe '#gamma' do
    it 'should calculate gamma function' do
      expect(Mathpack::Functions.gamma(1.5)).to be_between(0.886225, 0.886229)
      expect(Mathpack::Functions.gamma(1.8)).to be_between(0.9313835, 0.9313844)
      expect(Mathpack::Functions.gamma(5.8)).to be_between(85.62165, 85.62174)
      expect(Mathpack::Functions.gamma(3.75)).to be_between(4.422985, 4.422994)
      expect(Mathpack::Functions.gamma(7.68)).to be_between(2662.63, 2662.635)
    end
  end

  describe '#erf' do
    it 'should calculate erf function' do
      expect((Mathpack::Functions.erf(0.0) - 0.5).abs < 1e-7).to eq(true)
      expect((Mathpack::Functions.erf(1.73) - 0.9582).abs < 1e-4).to eq(true)
      expect((Mathpack::Functions.erf(3.49) - 0.9998).abs < 1e-4).to eq(true)
    end
  end

  describe '#beta' do
    it 'should calculate beta function' do
      expect(Mathpack::Functions.beta(3.5, 2.2)).to be_between(0.0504866, 0.05048665)
    end
  end

  describe '#dawson_plus' do
    it 'should calculate dawson_plus integral' do
      expect(Mathpack::Functions.dawson_plus(0.924138873)).to be_between(0.5410442, 0.54104425)
      expect(Mathpack::Functions.dawson_plus(1.5019752683)).to be_between(0.427686616, 0.4276866164)
    end
  end

  describe '#dawson_minus' do
    it 'should calculate dawson_minus integral' do
      expect(Mathpack::Functions.dawson_minus(0.924138873) + Mathpack::Functions.dawson_minus(-0.924138873) < 1e-5).to eq(true)
    end
  end
end
