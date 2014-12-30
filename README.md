# Mathpack
[![Gem Version](https://badge.fury.io/rb/mathpack.svg)](http://badge.fury.io/rb/mathpack)
[![Build Status](https://travis-ci.org/maxmilan/mathpack.svg?branch=master)](https://travis-ci.org/maxmilan/mathpack)

This gem includes a collection of mathematical methods

## Installation

Add this line to your application's Gemfile:

    gem 'mathpack'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mathpack
## Information
Gem `mathpack` allows to count statistical functions through `Statistics` class, solving nonlinear equations through `Equation` module
`solve` method
## Statistics
`Statistics` class have following methods
- **number** - returns a number of elements in series
- **mean** - returns a mean of series
- **variance** - returns a variance of series
- **skewness** - returns a skewness of series
- **kurtosis** - returns a kurtosis
- **min** - returns the minimal element of series
- **max** - returns the maxinal element of series
- **raw_moment** - returns the *nth* raw moment of series
- **central_moment** - returns the *nth* central moment of series
- **empirical_cdf** - returns *empirical distribution function* value in some point
- **empirical_pdf** - returns *empirical probability density function* value in some point
- **print_empirical_cdf_to_csv** - allows to print empirical_cdf line chart values to `.csv` file with name *filename*
- **print_empirical_cdf_to_csv** - allows to print empirical_cdf line chart values to `.csv` file with name *filename*

### Usage
```ruby
stat = Mathpack::Statistics.new([1, 2, 5, 6])
stat.number() #=> 4
stat.mean() #=> 3.5
stat.variance() #=> 4.25
stat.kurtosis() #=> 1.221453287197232
stat.skewness() #=> 0.0
stat.min() #=> 1
stat.max() #=> 6
stat.raw_moment(3) #=> 87.5
stat.central_moment(4) #=> 22.0625
stat.empirical_cdf(5.5) #=> 0.75
stat.empirical_pdf(3) #=> 0.07639393483317147
stat.print_empirical_cdf_to_csv('cdf.csv') #=> nil
stat.print_empirical_pdf_to_csv('pdf.csv') #=> nil
```

##Equation
`Equation` module has only one method
- **solve** - method, which allows to solve *nonlinear equations*. Neccessary params are `eps` representing calculations accuraccy and `start` representing point to start root search

###Usage
Now you have no problems solving **nonlinear equations**. If you want, for example, to solve equation ![equation](http://latex.codecogs.com/gif.latex?x%5E%7B2%7D%20%3D%20%5Csin%28%7Bx&plus;1%7D%29)

You need to complete the following steps:
- Equation should look like ![equation](http://latex.codecogs.com/gif.latex?%5Ctiny%20f%28x%29%20%3D%200)
- For our equation ![equation](http://latex.codecogs.com/gif.latex?%5Csmall%20f%28x%29%20%3D%20x%5E%7B2%7D%20-%20%5Csin%28x&plus;1%29)
- Choose the calculations accurracy. For example ![equation](http://latex.codecogs.com/gif.latex?%5Csmall%200.00001)
- Choose some point near the expected root of equation. For example ![equation](http://latex.codecogs.com/gif.latex?%5Csmall%200)

Then to solve equation you should call 
```ruby
Mathpack::Equation.solve(start: 0, eps: 0.00001){|x| x**2 - Math.sin(x+1)})
```
Here is some examples of **solve** function usage
```ruby
Mathpack::Equation.solve(start: 0, eps: 0.00001){|x| x**2 - Math.sin(x+1)})
Mathpack::Equation.solve(start: 0.01, eps: 0.00001){|x| 1/x - Math.log(x)})
Mathpack::Equation.solve(start: 0.01, eps: 0.00001){|x| x**2 - 2*x + 1})
Mathpack::Equation.solve(start: 0.01, eps: 0.00001){|x| Math.exp(x-2) - Math.sin(x)})
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/mathpack/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
