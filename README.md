# RType [![Build Status](https://travis-ci.org/ttakamura/robject.png?branch=master)](https://travis-ci.org/ttakamura/robject) [![Dependency Status](https://gemnasium.com/ttakamura/r_type.png)](https://gemnasium.com/ttakamura/r_type)

![r.type image](https://dl.dropboxusercontent.com/u/3111/rtype_1.png)

RType extend RSRuby to be rubyist can use R in a more Ruby way.

RSRuby provide to access R functions and variables from Ruby and basic class conversion.
And RType provide extended class conversion that convert R class to appropriate Ruby class that has many convenient methods.

## Convert R class to RType

* `matrix` => `RType::Matrix`
* `numeric` => `RType::Numeric`
* `vector` => `RType::Vector`
* `list` => `RType::List`
* `array` => `RType::Array`
* `data.frame` => `RType::DataFrame`
* `character` => `RType::String`
* other => `RType::Base`

## Installation

Add this line to your application's Gemfile:

    gem 'r_type'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install r_type

## Usage

### Interactive Console

Execute `r_console` to open interactive RType console.

```sh
r_console

> m = matrix (1..9).to_a, ncol: 3
=> [[1, 4, 7], [2, 5, 8], [3, 6, 9]]

> print m * m
     [,1] [,2] [,3]
[1,]   30   66  102
[2,]   36   81  126
[3,]   42   96  150
```

### Use RType in your Ruby Class

* Simple script

```ruby
a = RType::Matrix.new [1,2,3, 4,5,6], ncol: 2
b = RType::Matrix.new [10, 100], ncol: 1

RType::R.print a * b

#      [,1]
# [1,]  410
# [2,]  520
# [3,]  630
```

When you haven't define `::R` constant in your code, RType define `::R` as alias of `RType::R`. So, you can write following code.

```ruby
a = R::Matrix.new [1,2,3, 4,5,6], ncol: 2
b = R::Matrix.new [10, 100], ncol: 1

R.print a * b
```


* In `RType::R` context

`R.run` call given block in `RType::R` context.

```ruby
R.run do
  a = matrix [1,2,3, 4,5,6], ncol: 2
  b = matrix [10, 100], ncol: 1
  print a * b
end

#      [,1]
# [1,]  410
# [2,]  520
# [3,]  630
```


* Assign a variable from Ruby and use it in R

Call `RType::R.eval_R` with a string that has R code.

```ruby
# assign a value from Ruby
R.hoge = [1,2,3,4,5]

# eval R code
R.eval_R <<RTEXT
  f = function(x) x * 100
  result = sapply(hoge, f)
  print(result)
RTEXT
```

Or, you can use inline eval_R when `RType::R` context.

```ruby
R.run do
  hoge = [1,2,3,4,5]
  result = sapply hoge, `function(x) x * 100`
  print result
end
```


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
