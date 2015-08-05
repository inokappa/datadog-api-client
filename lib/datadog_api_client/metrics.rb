require 'rubygems'
require 'json'
require 'rest-client'
require 'date'
require 'time'

api_key = ENV["DATADOG_API_KEY"]
app_key = ENV["DATADOG_APP_KEY"]
from    = Time.parse("#{Date.today - 1}").to_i
to      = Time.parse("#{Date.today}").to_i
query   = ARGV[0]

r = RestClient.get 'https://app.datadoghq.com/api/v1/query', {:params => {:api_key => api_key, :application_key => app_key, :from => from, :to => to, :query => query}}
puts r
