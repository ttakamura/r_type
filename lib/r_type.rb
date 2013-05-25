require 'rsruby'
require 'delegate'
require File.expand_path('../r_type/version', __FILE__)
require File.expand_path('../r_type/helper', __FILE__)
require File.expand_path('../r_type/r', __FILE__)
require File.expand_path('../r_type/type/base', __FILE__)
require File.expand_path('../r_type/convert', __FILE__)
require File.expand_path('../r_type/type/matrix', __FILE__)
require File.expand_path('../r_type/type/vector', __FILE__)
require File.expand_path('../r_type/type/numeric', __FILE__)
require File.expand_path('../r_type/type/integer', __FILE__)
require File.expand_path('../r_type/type/string', __FILE__)
require File.expand_path('../r_type/type/list', __FILE__)
require File.expand_path('../r_type/type/array', __FILE__)
require File.expand_path('../r_type/type/data_frame', __FILE__)
require File.expand_path('../r_type/type/function', __FILE__)
require File.expand_path('../r_type/core_ext', __FILE__)

module RType
end

unless defined?(::R)
  ::R = RType::R
  ::R::Array     = RType::Array
  ::R::List      = RType::List
  ::R::Integer   = RType::Integer
  ::R::Function  = RType::Function
  ::R::DataFrame = RType::DataFrame
  ::R::Matrix    = RType::Matrix
  ::R::Numeric   = RType::Numeric
  ::R::String    = RType::String
  ::R::Vector    = RType::Vector
end
