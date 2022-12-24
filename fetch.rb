require "open-uri"
require "nokogiri"
require "yaml"
require "./metadata_service"
require "./data_fetch_service"

display_metadata = ARGV.include? "--metadata"

ARGV.each do |arg|
  if display_metadata
    next if arg == "--metadata"
    MetadataService::fetch(arg)
  else
    webpage_content = DataFetchService.new(url: arg).perform
    MetadataService.new(url: arg, webpage_content: webpage_content).update
  end
rescue => e
  puts "error: #{e}"
end