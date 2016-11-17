require 'sinatra'
require 'sinatra/reloader'
require 'thin'
require 'open-uri'
require_relative 'lib/job_search'
require 'json'
require 'net/http'


# homepage allows user to search for keyword and a location
  get "/" do
  ip = request.ip
  ip_info = JSON.parse(Net::HTTP.get("freegeoip.net", "/json/#{ip}"))

  location = ip_info["zip_code"] || ip_info["city"] || ip_info["region_name"]
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
