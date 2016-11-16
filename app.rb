require 'sinatra'
require 'sinatra/reloader'
require 'thin'
require_relative 'lib/job_search'


# homepage allows user to search for keyword and a location

get "/" do
  term = params[:term] || "ruby"
  location = params[:location] || "33603"

  jobs = JobSearch.new(term, location)

  erb :index, locals:{jobs: jobs}
end

post "/" do
  term = params[:term] || "ruby"
  location = params[:location] || "33603"

  jobs = JobSearch.new(term, location)

  erb :index, locals:{jobs: jobs}
end
