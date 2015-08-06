require "datadog_api_client/version"
require "datadog_api_client/dd_api_client"

module DatadogApiClient
  class << self

    def run(args)
      client = DdApiClient.new(args)

      if args[:endpoint] == "search"
        res = client.search
      elsif args[:endpoint] == "metrics"
        res = client.get_metrics
      elsif args[:endpoint] == "metrics"
        res = client.put_metrics
      else
        puts "Please set API endpoint."
      end
    end

  end
end
