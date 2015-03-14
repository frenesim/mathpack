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
`Mathpack` includes following modules:
- **SLE**. Solves system of linear equations
- **Statistics**. Provides methods to analyze data samples
- **Functions**. Collects mathematical functions
- **Approximation**. Allows to approximate table and analytical functions by polynom
- **Equation**. Solves unlinear mathematical equations
- **Integration**. Integrates functions
- **IO**. Prints data

## Statistics
`Statistics` class have following methods
#### number
returns a number of elements in series
#### mean 
returns a mean of series
#### variance
returns a variance of series
#### skewness
returns a skewness
#### kurtosis
returns a kurtosis
#### min
returns the minimal element of series
#### max
returns the maxinal element of series
#### raw_moment(n)
returns the **nth** raw moment of series
#### central_moment(n)
returns the **nth** central moment of series
#### empirical_cdf(x)
empirical distribution function value in **x**
#### empirical_pdf(x)
returns empirical probability density function value in **x**
#### print_empirical_cdf_to_csv(filename)
allows to print empirical_cdf table function to **filename.csv**
#### print_empirical_pdf_to_csv(filename)
allows to print empirical_pdf  table function to **filename.csv**
#### trend
returns trend polynom coefficients

### Usage
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
stat.print_empirical_cdf_to_csv('cdf') #=> nil
stat.print_empirical_pdf_to_csv('pdf') #=> nil
stat.trend(polynom_power: 1) #=> 1.7999999999999996*x - 0.9999999999999987
```

## Functions
`Functions` module includes a collection of popular functions.
#### gamma(x)
![equation](http://latex.codecogs.com/gif.latex?%5CGamma%28x%29%20%3D%20%5Cint_%7B0%7D%5E%7B%5Cinfty%7D%20x%5E%7Bt-1%7De%5E%7B-x%7Ddx)
#### beta(x, y)
![equation](http://latex.codecogs.com/gif.latex?B%28x%2C%20y%29%20%3D%20%5Cint_%7B0%7D%5E%7B1%7D%20t%5E%7Bx-1%7D%281-t%29%5E%7By-1%7Ddx)
#### erf(x) (Laplace function)
![equation](http://latex.codecogs.com/gif.latex?erf%28x%29%20%3D%20%5Cfrac%7B1%7D%7B%5Csqrt%7B2%5Cpi%7D%7D%20%5Cint_%7B-%5Cinfty%7D%5E%7Bx%7De%5E%7B-t%5E%7B2%7D%7Ddt)
#### dawson_plus(x)
![equation](http://latex.codecogs.com/gif.latex?D_%7B&plus;%7D%28x%29%20%3D%20e%5E%7B-x%5E%7B2%7D%7D%5Cint_%7B0%7D%5E%7Bx%7De%5E%7Bt%5E%7B2%7D%7Ddt)
#### dawson_minus(x)
![equation](http://latex.codecogs.com/gif.latex?D_%7B-%7D%28x%29%20%3D%20e%5E%7Bx%5E%7B2%7D%7D%5Cint_%7B0%7D%5E%7Bx%7De%5E%7B-t%5E%7B2%7D%7Ddt)

## Equation
#### solve(params = {})
returns solution of nonlinear equation. 
##### Parameters
- *start* - point to start root search
- *eps* - calculations accuraccy

### Usage
Now you have no problems solving nonlinear equations. If you want, for example, to solve equation ![equation](http://latex.codecogs.com/gif.latex?x%5E%7B2%7D%20%3D%20%5Csin%28%7Bx&plus;1%7D%29)

You need to complete the following steps:
- Equation should look like ![equation](http://latex.codecogs.com/gif.latex?%5Ctiny%20f%28x%29%20%3D%200)
- For our equation ![equation](http://latex.codecogs.com/gif.latex?%5Csmall%20f%28x%29%20%3D%20x%5E%7B2%7D%20-%20%5Csin%28x&plus;1%29)
- Choose the calculations accurracy. For example ![equation](http://latex.codecogs.com/gif.latex?%5Csmall%200.00001)
- Choose some point near the expected root of equation. For example ![equation](http://latex.codecogs.com/gif.latex?%5Csmall%200)

Then to solve equation you should call 
```ruby
Mathpack::Equation.solve(start: 0, eps: 0.00001){|x| x**2 - Math.sin(x+1)})
```
Here is some other examples of **solve** usage
```ruby
Mathpack::Equation.solve(start: 0, eps: 0.00001){|x| x**2 - Math.sin(x+1)})
Mathpack::Equation.solve(start: 0.01, eps: 0.00001){|x| 1/x - Math.log(x)})
Mathpack::Equation.solve(start: 0.01, eps: 0.00001){|x| x**2 - 2*x + 1})
Mathpack::Equation.solve(start: 0.01, eps: 0.00001){|x| Math.exp(x-2) - Math.sin(x)})
```

## SLE
#### solve(params = {})
returns solution of system of linear equations.
##### Parameters
- *matrix* - system matrix
- *f* - right part vector

### Usage
Let's solve some system of linear equations. It can be written as

![equation](http://latex.codecogs.com/gif.latex?%5Csmall%20AX%20%3D%20B)

where *A* is n-n matrix, *X* - vector of unknown, *B* - vector

If you want to solve this system you should call
```ruby
Mathpack::SLE.solve(matrix: A, f: B)
```
Parameter A can be Array or Matrix class. If Array is given result will be Array class. If Matrix is given result will be Matrix class.
```ruby
a = [[1, 2, 3], [4, 5, 6],[3, 5, 2]]
b = [15, 30, 15]
Mathpack::SLE.solve(matrix: a, f: b) #=> [-1.0, 2.0, 4.0]
a = Matrix[[1, 2, 3], [4, 5, 6],[3, 5, 2]]
b = Matrix.row_vector [15, 30, 15]
Mathpack::SLE.solve(matrix: a, f: b) #=> Matrix[[-1.0, 2.0, 4.0]]
```

## Approximation
#### approximate_by_polynom(params = {})
returns array of coefficients of polynom, approximating given function on [from, to] segment.
##### Parameters
- *x* - array of approximation nodes
- *polynom_power* - power of approximation polynom
- *f* - functions values in *x* if you have table function

#### generate_nodes(params = {}) 
returns nodes for approximation with some step.
##### Parameters
- *from* - first node
- *to* - last node
- *step* - step between nodes

#### print_polynom(coefficients)
returns a string representing polynom with given coefficients.

### Usage
```ruby
# Function to print polynom having it's coefficients
Mathpack::Approximation.print_polynom([1, -2, 1]) #=> x^2 - 2*x + 1

# Function to generate nodes for approximation. Only choose start value, end value and step
x = Mathpack::Approximation.generate_nodes(from: 0, to: 10, step: 0.25)
#=> [0, 0.25, ..., 10]

# Function that approximate given function by polynom with power polynom_power in approximation nodes x and returns coefficients of approximating polynom
result = Mathpack::Approximation.approximate_by_polynom(x: x, polynom_power: 5){ |x| Math.sin(x) }
#=> [0.0008009744982571882, -0.030619986086758588, 0.3805927651948083, -1.8481035413353888, 2.985465287759307, -0.3873066069630569]

# May be you want to print this polynom, let's call print_polynom function
Mathpack::Approximation.print_polynom(result)
#=> 0.0008009744982571882*x^5 - 0.030619986086758588*x^4 + 0.3805927651948083*x^3 - 1.8481035413353888*x^2 + 2.985465287759307*x - 0.3873066069630569

# If you have a table of values, where x - array of arguement values and f - array of function values, call approximate by polynom function with parameter f instead of block
result = Mathpack::Approximation.approximate_by_polynom(x: [1, 2, 3], f: [1, 4, 9], polynom_power: 2) #=> [1, 0, 0]
Mathpack::Approximation.print_polynom(result) #=> x^2
```

## Integration

#### integrate(params = {})
returns integral value.
##### Parameters
- *from* - start of integration
- *to* - end of integration

### Usage
Let you have the following integral:

![equation](http://latex.codecogs.com/gif.latex?%5Cint_%7Ba%7D%5E%7Bb%7Df%28x%29dx)

Where *a* can be finite or equal to ![equation](http://latex.codecogs.com/gif.latex?-%5Cinfty), and *b* can be finite or equal to ![equation](http://latex.codecogs.com/gif.latex?%5Cinfty). To find value of integral you should call **integrate** method of Integration module.
```ruby
Mathpack::Integration.integrate(from: a, to: b){ |x| f(x) }
```
Let's demostrate some examples of Integration module practical usage:
```ruby
Mathpack::Integration.integrate(from: 0, to: 3.6){ |x| Math.sin(x) / x } #=> 1.8219481156495034
Mathpack::Integration.integrate(from: 0, to: Float::INFINITY){ |x| Math.exp(-x) / (x + 1) } #=> 0.5963473623136091
Mathpack::Integration.integrate(from: -Float::INFINITY, to: Float::INFINITY){ |x| Math.exp(-x**2) * Math.cos(x) } #=> 1.3803884100161075
```

## IO

#### print_table_function(params = {})
writes table function values to *.csv* file
##### Parameters
- *filename* - name of output file
- *x* - arguements array
- *y* - function values array
- *labels* - hash of labels names for *x* and *y* column

### Usage

If you have table function, represented by argument array and function values array, you should use
**print_table_function**, that prints your data to **filename.csv** file.
```ruby
Mathpack::IO.print_table_function(filename: 'table.csv', x: [1, 2, 3], y: [2, 4, 6], labels: { x: 'x', y: 'f(x)'})
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/mathpack/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
