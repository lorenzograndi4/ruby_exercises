require 'rack'
require 'rack/lobster'
require_relative 'shrimp'

use Shrimp
run Rack::Lobster.new