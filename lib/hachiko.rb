require "hachiko/version"
require "hachiko/client"

module Hachiko
  class << self

    def run(args)
      client = Client.new(args)
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
