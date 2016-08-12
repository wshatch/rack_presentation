require 'rack'

app = Rack::Builder.new do
  an_app =  -> (env) { [200, {'Content-Type' => 'text/html; charset=UTF-8'}, ['This is an app']] }
  phisher = -> (env) { [404, {'Content-Type' => 'text/html; charset=UTF-8'}, ['doh! 404']] }

  map '/credit_card' do 
    run phisher
  end

  map '/' do
    run an_app
  end
end

real_phisher = -> (env) { [200, {'Content-Type' => 'text/html; charset=UTF-8'}, ['Please add a credit card number in the params']] }
run Rack::Cascade.new([
  app,
  real_phisher
])
