require "datadog_api_client/version"
require "datadog_api_client/dd_api_client"

module DatadogApiClient
  class << self
    def run(args)
      client = KvClient.new(args)
      if args[1] == 'list'
        puts client.listkv
      elsif args[1] == 'put'
        puts client.putkv
      elsif args[1] == 'delete'
        puts client.deletekv
      end
    end
  end
end
