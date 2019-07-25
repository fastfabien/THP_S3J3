 require 'bundler'
Bundler.require

$:.unshift File.expand_path("./../lib",__FILE__)
require 'app/scrapper.rb'
require 'app/spreadsheet.rb'
require 'app/csv.rb'

#user_finder = Scrapper.new

#user_finder.save_as_JSON

#sama = Spreadsheets.new
#sama.save_sa_spreadsheet

aspara = Csv.new
aspara.save_as_csv
