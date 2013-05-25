require File.expand_path('../../lib/r_type', __FILE__)

module RType::SpecDSL
  def rsruby_stub
    rsruby = double("rsruby")
    RType::R.stub(:rsruby).and_return(rsruby)
    proc_table = {}
    rsruby.stub(:default_mode=).with(4)
    rsruby.stub(:proc_table) { proc_table }
    rsruby
  end

  def rsruby_func_stub rsruby, name, args, response
    func = double(name.to_s)
    func.stub(:call).with(*args).and_return response
    func.stub(:is_function?).and_return true
    rsruby.stub(:[]).with(name).and_return func
    func
  end

  def rsruby_variable_stub rsruby, name, value
    variable = RType::Base.new double(name.to_s)
    variable.stub(:to_ruby).and_return value
    variable.stub(:is_function?).and_return false
    rsruby_func_stub rsruby, :assign, [name.to_s, value], variable
    rsruby.stub(:[]).with(name).and_return variable
    variable
  end
end

RSpec.configure do |config|
  config.mock_framework = :rspec
  config.include RType::SpecDSL
end
