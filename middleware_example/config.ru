require 'rack'

class RackApplication
  def call(env)
    return [200, {} ,["Hello World!"]]
  end
end

class HeaderMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    response = @app.call(env)
    response[2] = ["<h1> #{response[2][0]} </h1>"]
    return response
  end
end

class TimeMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    response = @app.call(env)
    time_string = Time.new.strftime("%I:%M")
    response[2] = ["#{response[2][0]} it is #{time_string}"]
    return response
  end
end

use HeaderMiddleware 
use TimeMiddleware
run RackApplication.new
