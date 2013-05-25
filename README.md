# RType [![Build Status](https://travis-ci.org/ttakamura/robject.png?branch=master)](https://travis-ci.org/ttakamura/robject)

![r.type image](https://dl.dropboxusercontent.com/u/3111/rtype_1.png)

RType extend RSRuby to be rubyist can use R in a more Ruby way.

RSRuby provide to access R functions and variables from Ruby and basic class conversion.
And RType provide extended class conversion that convert R class to appropriate Ruby class that has many convenient methods.

## Convert R class to RType

* `numeric` => `RType::Numeric`
* `vector` => `RType::Vector`
* `matrix` => `RType::Matrix`
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

### Include RType to your Ruby Class



## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
