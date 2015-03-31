module Mathpack
  module Functional
    @@minus = -> f,g { -> x { f.(x) - g.(x) } }
    @@div   = -> f,g { -> x { f.(x) / g.(x) } }
    @@mult  = -> f,g { -> x { f.(x) * g.(x) } }
    @@norm  = -> f   { -> x { f.(x).abs } }
    @@const = -> const { -> x { const} }

    @@plus_eps = -> eps { -> f { -> x { f.(x + eps) } } }
    @@min_eps  = -> eps { -> f { -> x { f.(x - eps) } } }

    @@inf = -> f,g { -> x { f.(x) < g.(x) } }

    @@lim = -> f,eps,prec {
      -> x {
        @@inf.(@@norm.(@@minus.(@@plus_eps.(eps/2.0).(f), @@plus_eps.(eps).(f))) , @@const.(prec) ).(x) ? @@plus_eps.(eps).(f).(x) : @@lim.(f,eps/2.0,prec).(x)
      }
    }

    @@derivative_sheme = -> f {
      -> x {
        -> eps {
          @@div.( @@minus.(@@plus_eps.(eps).(f), @@min_eps.(eps).(f) ), @@mult.(@@const.(2), @@const.(eps))).(x)
        }
      }
    }

    @@derivate = -> f{
      -> x {
        @@lim.(@@derivative_sheme.(f).(x),1, 1e-16).(0)
      }
    }

    @@n_times = -> n,f {
      n == 1 ? f : -> x { f.(@@n_times.(n - 1,f).(x))}
    }

    @@nth_derivator = -> n {
      @@n_times.(n,@@derivate)
    }

    def self.derivative(n, &f)
      @@nth_derivator.(n).(f)
    end
  end
end
