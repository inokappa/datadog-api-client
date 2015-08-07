require "hachiko/version"
require "hachiko/client"

module Hachiko
  class << self

    def run(args)
      client = Client.new(args)
      if args[:endpoint] == "search"
        puts client.search
      elsif args[:endpoint] == "metrics" && args[:metric] && args[:server] && args[:points]
        client.put_metrics
      elsif args[:endpoint] == "metrics"
        client.get_metrics
      elsif args[:endpoint] == "tags"
        puts client.tags
      else
        puts "Please check argument."
      end
    end

  end
end
