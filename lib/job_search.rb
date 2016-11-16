require_relative 'parse_dice'
require_relative 'parse_indeed'
require 'csv'

Job = Struct.new(:title, :link, :desc, :company, :company_url, :location, :date)

class JobSearch

  def initialize(term, location = nil)
    scrapers = [ParseDice.new(term, location),ParseIndeed.new(term, location)]
    create_job_array(run_scrapers(scrapers))
  end

  def run_scrapers(scrapers)
    results = []
    scrapers.each do |scraper|
      results << scraper.search
    end
    results.flatten
  end

  def to_csv(results)
    time = Time.now.strftime("%Y_%m_%d")
    CSV::open("jobs_#{time}.csv", "w+") do |csv|
      csv << ["Title", "Link", "Description", "Company", "Company Site", "Location", "Date"]
      results.compact.uniq.each do |result|
        csv << [result[:title], result[:link], result[:desc], result[:company], result[:company_url], result[:location], result[:date]]
      end
    end
  end

  def create_job_array(results)
    job_arr = []
    results.compact.uniq.each do |result|
      job_arr << Job.new(result[:title],
                        result[:link],
                        result[:desc],
                        result[:company],
                        result[:company_url],
                        result[:location],
                        result[:date])
    end
    job_arr
  end


end


dice = JobSearch.new( 'Developer', '33613' )
