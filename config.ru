# This file is used by Rack-based servers to start the application.

require_relative "config/environment"

# uses common logger i.e rails logger for both the apps.
use Rack::CommonLogger
map '/api' do
  run IterableSinatraApp.new
end

map '/' do
  run Rails.application
  Rails.application.load_server
end


