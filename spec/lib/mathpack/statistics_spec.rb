require 'mathpack'

describe Mathpack::Statistics do

  context 'calculate statistic parameters' do
    let(:data) do
      array = []
      array << [0]*50
      array << [1]*35
      array << [2]*10
      array << [3]*4
      array << [4]*1
      array.flatten
    end
    let(:stat) { Mathpack::Statistics.new(data) }

    describe '#number' do
      it 'calculates number of elements' do
        expect(stat.number).to eq(100)
      end
    end

    describe '#mean' do
      it 'calculates mean' do
        expect(stat.mean).to eq(0.71)
      end
    end

    describe '#varince' do
      it 'calculates variance' do
        expect(stat.variance).to eq(0.7659)
      end
    end

    describe '#skewness' do
      it 'calculates skewness' do
        expect(stat.skewness).to eq(1.3139557526940238)
      end
    end

    describe '#kurtosis' do
      it 'calculates kurtosis' do
        expect(stat.kurtosis).to eq(1.5654257435282322)
      end
    end

    describe '#min' do
      it 'finds the minimal element' do
        expect(stat.min).to eq(0)
      end
    end

    describe '#max' do
      it 'finds the maximal element' do
        expect(stat.max).to eq(4)
      end
    end

    describe '#raw_moment' do
      it 'calculates first raw moment equal to mean' do
        expect(stat.raw_moment(1)).to eq(stat.mean)
      end

      it 'calculates nth raw moment correctly' do
        expect(stat.raw_moment(3)).to eq(2.87)
      end
    end

    describe '#central_moment' do
      it 'calculates second central moment equal to variance' do
        expect(stat.central_moment(2)).to eq(stat.variance)
      end

      it 'calculates nth central moment correctly' do
        expect(stat.central_moment(5)).to eq(6.641392040400001)
      end
    end

    describe '#empirical_cdf' do
      it 'calculates empirical cdf values in points' do
        expect(stat.empirical_cdf(stat.min - 0.1)).to eq(0.0)
        expect(stat.empirical_cdf(stat.max + 0.1)).to eq(1.0)
        expect(stat.empirical_cdf(stat.mean)).to eq(0.5)
      end
    end

    describe '#empirical_pdf' do
      it 'calculates empirical pdf values in points' do
        expect(stat.empirical_pdf(stat.mean)).to eq( 0.4308095750697591)
      end
    end

    describe '#trend' do
      it 'returns formatted trend' do
        expect(stat.trend(polynom_power: 2)).to eq('0.00042531864230840915*x^2 - 0.016860573212183233*x + 0.12239332096475111')
      end
    end
  end
end
