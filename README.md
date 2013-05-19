# RObject

RObject is a wrapper library for RSRuby.

RSRuby provide to access R functions and variables from Ruby code. And, RObject wrap RSRuby's class to appropriate RObject class.

## Convert R class to RObject

* `numeric` => `RObject::Numeric`
* `vector` => `RObject::Vector`
* `matrix` => `RObject::Matrix`
* `list` => `RObject::List`
* `array` => `RObject::Array`
* `data.frame` => `RObject::DataFrame`
* `character` => `RObject::String`
* other => `RObject::Base`

## Installation

Add this line to your application's Gemfile:

    gem 'robject'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install robject

## Usage

Execute `robj_console` to open R-console

```sh
robj_console

> m = matrix (1..9).to_a, ncol: 3
=> [[1, 4, 7], [2, 5, 8], [3, 6, 9]]

> print m * m
     [,1] [,2] [,3]
[1,]   30   66  102
[2,]   36   81  126
[3,]   42   96  150
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
