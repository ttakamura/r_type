require 'pry'
require File.expand_path('../../lib/robject', __FILE__)

RObject::R.run do
  Pry.start binding, print: ->(output, value){ output.puts "=> #{value.inspect}" }
end
