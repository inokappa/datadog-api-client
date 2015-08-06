require "datadog_api_client/version"
require "datadog_api_client/dd_api_client"

module DatadogApiClient
  class << self

    def run(args)
      client = DdApiClient.new(args)
      if args[:endpoint] == "search"
        puts client.search
      elsif args[:endpoint] == "metrics" && args[:metric] && args[:server] && args[:points]
        puts client.put_metrics
      elsif args[:endpoint] == "metrics"
        puts client.get_metrics
      else
        puts "Please check argument."
      end
    end

  end
end
