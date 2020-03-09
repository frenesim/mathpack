describe 'IO' do
  require 'mathpack/io'

  describe '#parse_function' do
    it 'returns nil if function is not valid' do
      expect(Mathpack::IO.parse_function('puts "rm ."')).to be_nil
    end

    it 'returns nil if function have incorrect braces' do
      expect(Mathpack::IO.parse_function('e^(sin(x)')).to be_nil
    end

    it 'returns block if function is correct' do
      expect(Mathpack::IO.parse_function('e^(sin(x))').call(Math::PI / 2.0)).to eq(Math::E)
    end
  end
end
