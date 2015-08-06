#!/usr/bin/env ruby

require "datadog_api_client"

options={}
OptionParser.new do |opt|
  opt.on('-e', '--endpoint=NAME',  "API Endpoint Name. ex: metric ... Please see http://docs.datadoghq.com/ja/api/") {|v| options[:endpoint] = v}
  opt.on('-f', '--from=VALUE',     "From Epoch Time. ex: `date -d '5 minutes ago' +%s`")                             {|v| options[:from] = v}
  opt.on('-t', '--to=VALUE',       "To Epoch Time. ex: `date +%s`")                                                  {|v| options[:to] = v}
  opt.on('-q', '--query=VALUE',    "Query String. ex: system.cpu.idle{*}by{host}")                                   {|v| options[:query] = v}
  opt.on('-m', '--metric=NAME',    "Metric Name. ex: some.metric.name")                                              {|v| options[:metric] = v}
  opt.on('-p', '--points=VALUE',   "Metric Value or Values. ex: 12345 or [[POSIX_timestamp, numeric_value]]")        {|v| options[:points] = v}
  opt.on('-H', '--host=Name',      "Host Name. ex: foo.example.com")                                                 {|v| options[:host] = v}

  opt.parse!(ARGV)
end

DatadogApiClient.run(options)
