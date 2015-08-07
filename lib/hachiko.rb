require "hachiko/version"
require "hachiko/client"

module Hachiko
  class << self

    def run(args)
      client = Client.new(args)
      if args[:endpoint] == "search"
        puts client.search
      elsif args[:endpoint] == "metrics"
        puts client.metrics
      elsif args[:endpoint] == "tags"
        puts client.tags
      elsif args[:endpoint] == "hosts"
        puts client.mute_host
      else
        puts "Please check argument."
      end
    end

  end
end
