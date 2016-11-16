require 'sinatra'
require 'sinatra/reloader'
require 'thin'
require_relative 'lib/job_search'


# homepage allows user to search for keyword and a location

get "/" do
  term = params[:term] || "developer"
  JobSearch.new(term)
  erb :index
end
