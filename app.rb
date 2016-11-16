require 'sinatra'
require 'sinatra/reloader'
require 'thin'
require 'open-uri'
require_relative 'lib/job_search'


# homepage allows user to search for keyword and a location

get "/" do

  term = params[:term] || "ruby"
  location = params[:location] || open("freegeoip.net/json/#{request.ip}")

  jobs = JobSearch.new(term, location)

  erb :index, locals:{jobs: jobs}

end

post "/" do
  term = params[:term] || "ruby"
  location = params[:location] || "33603"

  jobs = JobSearch.new(term, location)

  erb :index, locals:{jobs: jobs}
end
