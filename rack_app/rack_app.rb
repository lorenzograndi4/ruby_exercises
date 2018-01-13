require 'rack'
require_relative 'fortune'

app = Proc.new do |env|
  ['200', { 'Content-Type' => 'text/plain' }, [Fortune.wisdom]]
end

Rack::Handler::WEBrick.run app
