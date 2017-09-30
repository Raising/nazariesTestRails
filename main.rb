require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'json'
load 'monitorPricingWebParser.rb'  

page = Nokogiri::HTML(open("https://port-monitor.com/plans-and-pricing"))
parser = MonitorPricingWebParser.new

productsObject = parser.retrieveMonitorPricing(page)

puts JSON.pretty_generate(productsObject)