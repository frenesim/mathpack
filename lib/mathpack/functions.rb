module Mathpack
  module Functions
    def self.gamma(t)
      Mathpack::Integration.integrate(from: 0.0, to: Float::INFINITY) { |x| x**(t-1) * Math.exp(-x) }
    end

    def self.erf(x)
      1.0 / (2.0 * Math::PI)**0.5 * Mathpack::Integration.integrate(from: -Float::INFINITY, to: x) { |u| Math.exp(-u**2 / 2.0) }
    end

    def self.beta(a, b)
      gamma(a) * gamma(b) / gamma(a + b)
    end

    def self.dawson_plus(x)
      Math.exp(-x**2) * Mathpack::Integration.integrate(from: 0.0, to: x) { |x| Math.exp(x**2) }
    end

    def self.dawson_minus(x)
      Math.exp(x**2) * Mathpack::Integration.integrate(from: 0.0, to: x) { |x| Math.exp(-x**2) }
    end

    def self.heaviside(x)
      x <= 0.0 ? 0 : 1
    end
  end
end
