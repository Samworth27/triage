# frozen_literal_string: true

# Load all children
Dir.glob(File.expand_path("../#{File.basename(__FILE__, ".*")}/*.rb", __FILE__)).each { |file| require_relative "#{File.basename(__FILE__, ".*")}/#{File.basename(file)}"}

require 'tty-prompt'

require_relative '../app_errors'

# Api Reference
# https://www.icpc-3.info/documents/extra/API-Calls.pdf

# Structure used to fetch and store information IRT the ICPC
# (Internation classification of Primary Care) using their own HTTP APIs
class SymptomsDatabase
  include DBBuild
  include DBCalls
  include DBBRowse

  

  # No need for any arguments
  def initialize
    @storage = PStore.new('./db/storage.pstore')
    fetch_data if prompt?(main: 'Fetch new data?',help: 'Fetches data from the internet. May take a few minutes')
    reload_database if prompt?(main: 'Update database from local JSON file', help: 'May take up to 20 seconds to complete')
  end

  def to_s
    @storage.transaction do
      "Database containing #{@storage[:size]} items"
    end
    
  end

  def codes  
    @storage.transaction do
      return @storage[:codes]
    end
  end

  def reload_database
    json = File.open('./db/.cached/symptoms.json')
    json = json.read
    json = JSON.parse(json, symbolize_names: true)
    build(json[0])
    clear_screen
  end

  def prompt?(main:, help: '')
    prompt = TTY::Prompt.new
    clear_screen
    prompt.select(
      main,
      [{value: false, name:'no'},{value: true, name: 'yes'}],
      help: help,
      show_help: :always
    )
  end
end
