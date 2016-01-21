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
- **NonlinearEquations**. Solves unlinear mathematical equations
- **IntegralEquations**. Solves integral second order Fredholm and Volter equations
- **DifferentialEquations**. Solves system of differential equations with left border initial conditions
- **Integration**. Integrates functions
- **IO**. Prints data
- **Functional**. Lambda functions

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
#### print_empirical_cdf(filename)
allows to print empirical_cdf table function to **filename**
#### print_empirical_pdf(filename)
allows to print empirical_pdf  table function to **filename**
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
stat.print_empirical_cdf('cdf.csv') #=> nil
stat.print_empirical_pdf('pdf.csv') #=> nil
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

## NonlinearEquations
#### solve(params = {})
returns solution of nonlinear equation. 
##### Parameters
- ***start*** - point to start iteration process
- ***eps*** - calculations accuraccy

### Usage
Now you have no problems solving nonlinear equations. If you want, for example, to solve equation ![equation](http://latex.codecogs.com/gif.latex?x%5E%7B2%7D%20%3D%20%5Csin%28%7Bx&plus;1%7D%29)

You need to complete the following steps:
- Equation should look like ![equation](http://latex.codecogs.com/gif.latex?%5Ctiny%20f%28x%29%20%3D%200)
- For our equation ![equation](http://latex.codecogs.com/gif.latex?%5Csmall%20f%28x%29%20%3D%20x%5E%7B2%7D%20-%20%5Csin%28x&plus;1%29)
- Choose the calculations accurracy. For example ![equation](http://latex.codecogs.com/gif.latex?%5Csmall%200.00001)
- Choose some point near the expected root of equation. For example ![equation](http://latex.codecogs.com/gif.latex?%5Csmall%200)

Then to solve equation you should call 
```ruby
Mathpack::NonlinearEquations.solve(start: 0, eps: 0.00001){|x| x**2 - Math.sin(x+1)})
```
Here is some other examples of **solve** usage
```ruby
Mathpack::NonlinearEquations.solve(start: 0, eps: 0.00001){|x| x**2 - Math.sin(x+1)})
Mathpack::NonlinearEquations.solve(start: 0.01, eps: 0.00001){|x| 1/x - Math.log(x)})
Mathpack::NonlinearEquations.solve(start: 0.01, eps: 0.00001){|x| x**2 - 2*x + 1})
Mathpack::NonlinearEquations.solve(start: 0.01, eps: 0.00001){|x| Math.exp(x-2) - Math.sin(x)})
```
#### solve_system(params = {})
returns solution of system of nonlinear equations by *Newton method*
##### Parameters
- ***start*** - vector to start iteration process
- ***eps*** - calculations accuraccy
- ***f*** - vector of right part lambdas
- ***w_matrix*** - matrix *W* in Newton method

### Usage
If you have system of equations ![equation](http://latex.codecogs.com/gif.latex?f_%7Bi%7D%28x%29%20%3D%200%2C%20i%20%3D%200%2C%201%2C%20...%2C%20N-1)

![equation](http://latex.codecogs.com/gif.latex?f%28x%29%20%3D%20%5Cbegin%7Bpmatrix%7D%20f_%7B0%7D%28x%29%5C%5C%20%5Ccdots%5C%5C%20f_%7BN-1%7D%28x%29%20%5Cend%7Bpmatrix%7D)

![equation](http://latex.codecogs.com/gif.latex?W%28x%29%20%3D%20%5Cbegin%7Bpmatrix%7D%20%5Cfrac%7B%5Cpartial%20f_%7B0%7D%28x%29%7D%7B%5Cpartial%20x_%7B0%7D%7D%26%5Ccdots%26%5Cfrac%7B%5Cpartial%20f_%7B0%7D%28x%29%7D%7B%5Cpartial%20x_%7BN-1%7D%7D%5C%5C%20%5Ccdots%26%5Cddots%20%26%5Ccdots%20%5C%5C%20%5Cfrac%7B%5Cpartial%20f_%7BN-1%7D%28x%29%7D%7B%5Cpartial%20x_%7B0%7D%7D%26%5Ccdots%26%20%5Cfrac%7B%5Cpartial%20f_%7BN-1%7D%28x%29%7D%7B%5Cpartial%20x_%7BN-1%7D%7D%5C%20%5Cend%7Bpmatrix%7D)

For example, if you have system

![equation](http://latex.codecogs.com/gif.latex?%5Cleft%5C%7B%5Cbegin%7Bmatrix%7D%20x_%7B1%7D%20&plus;%20x_%7B2%7D%20-%203%20%3D%200%5C%5C%20%7Bx_%7B1%7D%7D%5E%7B2%7D%20&plus;%20%7Bx_%7B2%7D%7D%5E2%20-%209%20%3D%200%20%5Cend%7Bmatrix%7D%5Cright.)

W matrix and f vector is equal

![equation](http://latex.codecogs.com/gif.latex?W%28x%29%20%3D%20%5Cbigl%28%5Cbegin%7Bsmallmatrix%7D%201%20%26%201%5C%5C%202x_%7B1%7D%262x_%7B2%7D%20%5Cend%7Bsmallmatrix%7D%5Cbigr%29)

![equation](http://latex.codecogs.com/gif.latex?f%28x%29%20%3D%20%5Cbigl%28%5Cbegin%7Bsmallmatrix%7D%20x_%7B1%7D%20&plus;%20x_%7B2%7D%20-%203%5C%5C%20%7Bx_%7B1%7D%7D%5E%7B2%7D%20&plus;%20%7Bx_%7B2%7D%7D%5E%7B2%7D%20-%209%20%5Cend%7Bsmallmatrix%7D%5Cbigr%29)
```ruby
f = -> x, y { [x + y - 3.0, x**2 + y**2 - 9.0] }
w = -> x, y { [[1, 1], [2 * x, 2 * y]] }
Mathpack::NonlinearEquations.solve_system(start: [1, 5], eps: 1e-4, f: f, w_matrix: w) #=> [-1.829420851037002e-12, 3.0000000000018296]
```

## IntegralEquations
#### solve_fredholm_2(params={})
returns solution of integral equation as a hash of nodes and values arrays.
##### Parameters
- ***from*** - left border
- ***to*** - right border
- ***lambda*** - *lambda* parameter
- ***k*** - kernel function (2 arguements)
- ***f*** - inhomogeneity function (1 arguement)
- ***eps*** - accuracy

### Usage
Let we have the following integral equation

![equation](http://latex.codecogs.com/gif.latex?u%28x%29%20-%20%5Cfrac%7B1%7D%7B2%7D%5Cint_%7B1%7D%5E%7B2%7D%5Cfrac%7Bu%28t%29%29%7D%7B%5Csqrt%7Bx&plus;t%5E%7B2%7D%7D%7Ddt%20%3D%202x%20&plus;%20%5Csqrt%7Bx&plus;1%7D%20-%20%5Csqrt%7Bx&plus;4%7D)

If you want to solve equation with accuracy **1e-5**, you should call
```ruby
k = -> x, t { 1.0 / (x + t**2)**0.5 }
f = -> x { 2*x + (x + 1)**0.5 - (x + 4)**0.5 }
Mathpack::IntegralEquations.solve_fredholm_2(from: 1.0, to: 2.0, lambda: 0.5, eps: 1e-5, k: k, f: f)
#=> {:x=>[1.0, 1.125, 1.25, 1.375, 1.5, 1.625, 1.75, 1.875, 2.0], :f=>[1.9999989550044168, 2.2499991010033416, 2.499999229316462, 2.7499993410739187, 2.9999994379022, 3.2499995215457123, 3.4999995936848047, 3.7499996558559117, 3.9999997094242845]} 
```

#### solve_volter_2(params{})
returns solution of integral equation as a hash of nodes and values arrays.
##### Parameters
- ***from*** - left border
- ***to*** - right border
- ***lambda*** - *lambda* parameter
- ***k*** - kernel function (2 arguements)
- ***f*** - inhomogeneity function (1 arguement)
- ***eps*** - accuracy

### Usage
Let we have the following integral equation

![equation](http://latex.codecogs.com/gif.latex?u%28x%29%20%3D%20%5Cfrac%7B1%7D%7B2%7D%5Cint_%7B0%7D%5E%7Bx%7Dcos%28x-t%29u%28t%29dt%20&plus;%20%5Cfrac%7B3%7D%7B4%7De%5E%7Bx%7D%20&plus;%20%5Cfrac%7B1%7D%7B4%7Dcosx-%5Cfrac%7B1%7D%7B4%7Dsinx%2C%200%5Cleq%20x%20%5Cleq%201)

If you want to solve equation with accuracy **1e-3**, you should call
```ruby
k = -> x, t { Math.cos(x - t) }
f = -> x { 0.75 * Math.exp(x) + 0.25 * Math.cos(x) - 0.25 * Math.sin(x) }
Mathpack::IntegralEquations.solve_volter_2(from: 0.0, to: 1.0, lambda: 0.5, eps: 1e-3, k: k, f: f)
#=> {:x=>[0.0, 0.0625, 0.125, 0.1875, 0.25, 0.3125, 0.375, 0.4375, 0.5, 0.5625, 0.625, 0.6875, 0.75, 0.8125, 0.875, 0.9375, 1.0], :f=>[1.0, 1.0644951210235056, 1.1331511709098798, 1.2062365414157485, 1.2840369296892897, 1.3668564541117094, 1.455018842114489, 1.5488686946157586, 1.6487728320186184, 1.755121727033003, 1.868331029922017, 1.9888431921348702, 2.117129194673052, 2.2536903879456665, 2.3990604503055315, 2.5538074729214233, 2.718536179135541]}  
```

## DifferentialEquations
#### solve_cauchie_system(params={})
returns solution of differential equations system as a hash of nodes and values arrays for each function. For example, { x: [], u1: [], u2: [], ...  }
##### Parameters
- ***from*** - left border
- ***to*** - right border
- ***system*** - array of lambdas representing each row of system
- ***y0*** - array of values of derivatives on left border. Starts with first derivative
- ***eps*** - accuracy

### Usage
Let we have following system of differential equations

![equation](http://latex.codecogs.com/gif.latex?%5Cleft%5C%7B%5Cbegin%7Bmatrix%7D%20%7Bu_%7B1%7D%7D%27%3Du_%7B2%7D%26%26u_%7B1%7D%281%29%3D1%20%5C%5C%20%7Bu_%7B2%7D%7D%27%3D%5Cfrac%7B1%7D%7Bx%5E%7B2%7D%7Du_%7B1%7D-%5Cfrac%7B1%7D%7Bx%7Du_%7B2%7D&plus;3%26%26u_%7B2%7D%281%29%3D1%20%5Cend%7Bmatrix%7D%5Cright.)

where

![equation](http://latex.codecogs.com/gif.latex?1%5Cleq%20x%5Cleq%202)

If you want to solve this system with accuracy **1e-6**, you should call
```ruby
cauchie_problem = [ ->(x, u1, u2) { u2 }, -> (x, u1, u2) { - 1.0 / x  * u2 + 1.0 / x**2 * u1 + 3.0 }]
Mathpack::DifferentialEquations.solve_cauchie_system(from: 1.0, to: 2.0, eps: 1e-6, system: cauchie_problem, y0: [1.0, 1.0])
#=> {:x=>[1.0,..., 2.0], :u1=>[1,...], :u2=>[1,...] }
```

## SLE
#### solve(params = {})
returns solution of system of linear equations.
##### Parameters
- ***matrix*** - system matrix
- ***f*** - right part vector

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
- ***x*** - array of approximation nodes
- ***polynom_power*** - power of approximation polynom
- ***f*** - functions values in *x* if you have table function

#### generate_nodes(params = {}) 
returns nodes for approximation with some step.
##### Parameters
- ***from*** - first node
- ***to*** - last node
- ***step*** - step between nodes

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
- ***from*** - start of integration
- ***to*** - end of integration

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
writes table function values to file
##### Parameters
- ***filename*** - name of output file
- ***x*** - arguements array
- ***y*** - function values array
- ***labels*** - hash of labels names for *x* and *y* column

#### read_table_function(filename)
returns table function values hash, written to **filename**

### Usage

If you have table function, represented by argument array and function values array, you should use
**print_table_function**, that prints your data to **filename** file.
If you have table function, written to **filename** file, you should use **read_table_function**, that 
```ruby
Mathpack::IO.print_table_function(filename: 'table.csv', x: [1, 2, 3], y: [2, 4, 6], labels: { x: 'x', y: 'f(x)'})
Mathpack::IO.read_table_function('table.csv') #=> { x: [1, 2, 3], y: [2, 4, 6] }
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/mathpack/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
