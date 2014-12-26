# Mathpack
[![Gem Version](https://badge.fury.io/rb/mathpack.svg)](http://badge.fury.io/rb/mathpack)

This gem includes collection of mathematical methods

## Installation

Add this line to your application's Gemfile:

    gem 'mathpack'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mathpack
## Information
Gem `mathpack` allows to count statistical functions throught `Statistics` class
## Statistics
`Statistics` class have following methods
- **number** - returns a number of elements in series
- **mean** - returns a mean of series
- **variance** - returns a variance of series
- **skewness** - returns a skewness of series
- **kurtosis** - returns a kurtosis
- **min** - returns the minimal element of series
- **max** - returns the maxinal element of series
- **number** - returns a number of elements in array
- **raw_moment** - returns the *nth* raw moment of series
- **central_moment** - returns the *nth* central moment of series
- **empirical_cdf** - returns *empirical distribution function* value in some point
- **empirical_pdf** - returns *empirical probability density function* value in some point
- **print_empirical_cdf_to_csv** - allows to print empirical_cdf grafic values to `.csv` file with name *filename*
- **print_empirical_cdf_to_csv** - allows to print empirical_cdf grafic values to `.csv` file with name *filename*

## Usage
```ruby
stat = Mathpack::Statistics.new([1, 2, 5, 6])
stat.number() #=> 4
stat.mean() #=> 3.5
stat.variance() #=> 4.25 
stat.kurtosis() #=> -1.778546712802768
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

## Contributing

1. Fork it ( https://github.com/[my-github-username]/mathpack/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
