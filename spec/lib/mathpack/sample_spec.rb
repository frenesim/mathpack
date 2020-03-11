require 'mathpack'

describe Mathpack::Statistics do

  context 'calculate statistic parameters' do
    let(:data) do
      [
        [0]*50,
        [1]*35,
        [2]*10,
        [3]*4,
        [4]
      ].flatten
    end

    let :another_data do
      [
        -0.05,
        0.042105263157895,
        -0.040404040404041,
        -0.010526315789474,
        -0.01063829787234,
        0.075268817204301,
        0.05,
        0.064935238095238,
        0.099999821138241,
      ]
    end


    let :stat_sample_data do
      Mathpack::Sample.new(data)
    end

    let :stat_sample_another_stat do
      Mathpack::Sample.new(another_data)
    end

    describe '#variance' do
      it 'calculates number of elements' do
        expect(stat_sample_data.variance).to eq 0.7736363636363637
        expect(stat_sample_another_stat.variance).to eq 0.002887152546613119
      end
    end

    describe '#standard_deviation' do
      it 'calculates standard_deviation' do
        expect(stat_sample_data.standard_deviation).to eq(0.8795660086863087)
      end
      it 'calculates variance for a sample' do
        expect(stat_sample_another_stat.standard_deviation).to eq(0.05373223005434558)
      end
    end

    describe '#skewness' do
      it 'calculates skewness' do
        expect(stat_sample_another_stat.skewness).to eq(-0.10746344126375895)
        expect(stat_sample_data.skewness).to eq(1.3139557526940238)
      end
    end

    it 'central_moment(4)' do
      # expect(stat_sample_another_stat.average).to eq 4
      expect(stat_sample_another_stat.central_moment(4)).to eq(1.0435749069508274e-05)
    end

    describe '#kurtosis' do
      it 'calculates skewness' do
        expect(stat_sample_another_stat.kurtosis).to eq(-1.4155110651771563)
        expect(stat_sample_data.kurtosis).to eq(1.5654257435282322)
      end
    end

  end
end