require 'sinatra'
require 'sinatra/reloader'
require 'thin'
require 'open-uri'
require_relative 'lib/job_search'
require 'json'
require 'pry'
require 'pry-byebug'


# homepage allows user to search for keyword and a location
# file_contents = open('local-file.txt') { |f| f.read }
get "/" do
  ip = JSON.parse(`curl freegeoip.net/json/`)
  location = ip["zip_code"] || ip["city"] || ip["region_name"]
  term = "developer"

  jobs = JobSearch.new(term, location)

  erb :index, locals:{jobs: jobs}

end

post "/" do
  term = params[:term] || "ruby"
  location = params[:location] || "33603"

  jobs = JobSearch.new(term, location)

  erb :index, locals:{jobs: jobs}
end
