describe 'Statistics' do
  require 'mathpack/statistics'

  describe "calculated statistics functions" do

    let(:data) { [1,5,4,2,3,4,5,7,2,7] }
    let(:stat) { Mathpack::Statistics.new(data) }

    it "calculates the number" do
      expect(stat.number).to eql(10)
    end

    it "calculates the mean" do
      expect(stat.mean).to eql(4.0)
    end

    it "calculates the variance" do
      expect(stat.variance).to eql(3.8)
    end

    it "calculates the skewness" do
      expect(stat.skewness).to eql(0.16199658190818222)
    end

    it "calculates the kurtosis" do
      expect(stat.kurtosis).to eql(1.925207756232687)
    end

    it "calculates the minimal element" do
      expect(stat.min).to eql(1)
    end

    it "calculates maximal element" do
      expect(stat.max).to eql(7)
    end

    it "calculates first raw moment equal to mean" do
      expect(stat.raw_moment(1)).to eql(stat.mean)
    end

    it "calculates second central moment equal to variance" do
      expect(stat.central_moment(2)).to eql(stat.variance)
    end

    it "calculates raw moment" do
      expect(stat.raw_moment(3)).to eql(110.8)
    end

    it "calculates central moment" do
      expect(stat.central_moment(5)).to eql(18.0)
    end

    it "calculates empirical cdf" do
      expect(stat.empirical_cdf(stat.min - 0.1)).to eql(0.0)
      expect(stat.empirical_cdf(stat.max + 0.1)).to eql(1.0)
      expect(stat.empirical_cdf(stat.mean)).to eql(0.4)
    end

    it "calculates empirical pdf" do
      expect(stat.empirical_pdf(stat.mean)).to eql(0.1882412842233359)
    end
  end
end
