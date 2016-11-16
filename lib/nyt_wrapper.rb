# An example of building a simple wrapper around the
# New York Times API's Most Popular endpoints
# Run from CLI with `$ API_KEY=your_key_here ruby nyt_api.rb`

require 'typhoeus'
require 'json'

# For better debugging
require 'pry-byebug'
require 'pp' # Lets us prettyprint with `pp(some_json_object)`


class NYT

  # Set some constants that we know will be constant
  BASE_URI = "http://api.nytimes.com/svc/mostpopular/v2"

  # Don't expose it, use ENV Vars
  # remember, you got this by registering
  API_KEY = ENV["API_KEY"]

  VALID_FORMATS = [:json]   # skip XML for now
  VALID_PERIODS = [1, 7, 30]


  # Time period is in days
  # Response format is a string or symbol
  def initialize(time_period, response_format)
    validate_time_period!(time_period)
    validate_format!(response_format)

    @time_period = time_period
    @format = response_format.to_s.downcase
  end