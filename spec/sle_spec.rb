describe 'SLE' do
  require 'mathpack/sle'

  context '#solve systems of linear equations' do
    let(:a) { [[1, 2, 3], [4, 5, 6], [3, 5, 2]] }
    let(:unsolved) { [[1, 2, 3], [1, 2, 3], [3, 5, 2]] }
    let(:b) { [15, 30, 15] }
    let(:matrix_a) { Matrix[[1, 2, 3], [4, 5, 6], [3, 5, 2]] }
    let(:vector_b) { Matrix.row_vector([15, 30, 15])  }

    it 'should give correct answer' do
      expect(Mathpack::SLE.solve(matrix: a, f: b)).to eq([-1.0, 2.0, 4.0])
    end

    it 'should raise error when matrix is singular' do
      expect { Mathpack::SLE.solve(matrix: unsolved, f: b) }.to raise_error
    end

    it 'should raise error when matrix has incorrect size' do
      b << 1
      expect { Mathpack::SLE.solve(matrix: a, f: b) }.to raise_error
      b.pop
      a << [1, 2, 3, 4]
      expect { Mathpack::SLE.solve(matrix: a, f: b) }.to raise_error
    end

    it 'should return vector if matrix class is given' do
      expect(Mathpack::SLE.solve(matrix: matrix_a, f: vector_b)).to eq(Matrix.row_vector [-1.0, 2.0, 4.0])
    end

    it 'should not change source data' do
      Mathpack::SLE.solve(matrix: a, f: b)
      expect(a).to eq([[1, 2, 3], [4, 5, 6], [3, 5, 2]])
      expect(b).to eq([15, 30, 15])
    end
  end
end
