require 'rubygems'
require 'dogapi'
require 'json'
require 'optparse'

api_key=ENV["DATADOG_API_KEY"]
app_key=ENV["DATADOG_APP_KEY"]

option={}
OptionParser.new do |opt|
  opt.on('-q', '--query=VALUE',  "Query String(Required). ex: your_host_name") {|v| option[:query] = v}

  opt.parse!(ARGV)
end

dog = Dogapi::Client.new(api_key, app_key)

# Search by `host` facet.
# r = dog.search("hosts:#{ARGV[0]}")
# puts r[1].to_json
# 
# # Search by `metric` facet.
# r = dog.search("metrics:#{ARGV[0]}")
# puts r[1].to_json

# Search all facets.
r = dog.search(option[:query])
puts r[1].to_json
