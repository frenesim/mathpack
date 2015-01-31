describe 'Statistics' do
  require 'mathpack/statistics'

  describe '#calculate statistics functions' do

    let(:data) { [1, 5, 4, 2, 3, 4, 5, 7, 2, 7] }
    let(:stat) { Mathpack::Statistics.new(data) }

    it 'should calculate number of elements' do
      expect(stat.number).to eql(10)
    end

    it 'should calculate mean' do
      expect(stat.mean).to eql(4.0)
    end

    it 'should calculate variance' do
      expect(stat.variance).to eql(3.8)
    end

    it 'should calculate skewness' do
      expect(stat.skewness).to eql(0.16199658190818222)
    end

    it 'should calculate kurtosis' do
      expect(stat.kurtosis).to eql(1.925207756232687)
    end

    it 'should calculate the minimal element' do
      expect(stat.min).to eql(1)
    end

    it 'should calculate the maximal element' do
      expect(stat.max).to eql(7)
    end

    it 'should calculate first raw moment equal to mean' do
      expect(stat.raw_moment(1)).to eql(stat.mean)
    end

    it 'should calculate second central moment equal to variance' do
      expect(stat.central_moment(2)).to eql(stat.variance)
    end

    it 'should calculate raw moments' do
      expect(stat.raw_moment(3)).to eql(110.8)
    end

    it 'should calculate central moments' do
      expect(stat.central_moment(5)).to eql(18.0)
    end

    it 'should calculate empirical cdf values in points' do
      expect(stat.empirical_cdf(stat.min - 0.1)).to eql(0.0)
      expect(stat.empirical_cdf(stat.max + 0.1)).to eql(1.0)
      expect(stat.empirical_cdf(stat.mean)).to eql(0.4)
    end

    it 'should calculate empirical pdf values in points' do
      expect(stat.empirical_pdf(stat.mean)).to eql(0.1882412842233359)
    end

    it 'should find trend' do
      expect(stat.trend(polynom_power: 2)).to eql('0.0075757575757576055*x^2 + 0.2681818181818179*x + 2.233333333333334')
    end
  end
end
