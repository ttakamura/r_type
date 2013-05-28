guard 'rspec' do
  watch %r{^spec/(.+_spec\.rb)$} do |m|
    "spec/#{m[1]}"
  end

  watch %r{^lib/r_type/(.+)\.rb$} do |m|
    "spec/#{m[1]}_spec.rb"
  end
end
