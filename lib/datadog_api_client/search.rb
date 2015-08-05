require 'rubygems'
require 'dogapi'
require 'json'

api_key=ENV["DATADOG_API_KEY"]
app_key=ENV["DATADOG_APP_KEY"]

dog = Dogapi::Client.new(api_key, app_key)

# Search by `host` facet.
r = dog.search("hosts:#{ARGV[0]}")
puts r[1].to_json

# Search by `metric` facet.
r = dog.search("metrics:#{ARGV[0]}")
puts r[1].to_json

# Search all facets.
r = dog.search("#{ARGV[0]}")
puts r[1].to_json
