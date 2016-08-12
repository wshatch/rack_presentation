require 'rack'
require 'pry'

application = Proc.new do |env|
  binding.pry
  return [200, {}, ["Hello world!"]]
end

run application
