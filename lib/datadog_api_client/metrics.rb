require 'rubygems'
require 'json'
require 'rest-client'
require 'date'
require 'time'
require 'optparse'

api_key = ENV["DATADOG_API_KEY"]
app_key = ENV["DATADOG_APP_KEY"]

option={}
OptionParser.new do |opt|
  opt.on('-f', '--from=VALUE',   "From Epoch Time. ex: `date -d '5 minutes ago' +%s`")     {|v| option[:from] = v}
  opt.on('-t', '--to=VALUE',     "To Epoch Time. ex: `date +%s`")                          {|v| option[:to] = v}
  opt.on('-q', '--query=VALUE',  "Query String(Required). ex: system.cpu.idle{*}by{host}") {|v| option[:query] = v}

  opt.parse!(ARGV)
end

r = RestClient.get 'https://app.datadoghq.com/api/v1/query', {
  :params => {
    :api_key => api_key,
    :application_key => app_key,
    :from => option[:from],
    :to => option[:to],
    :query => option[:query]
  }
}
puts r
