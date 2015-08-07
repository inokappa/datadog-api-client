module Hachiko
  class Client
    
    def initialize(args)
      require 'dogapi'
      require 'rest-client'
      require 'json'

      @api_key      = ENV["DATADOG_API_KEY"]
      @app_key      = ENV["DATADOG_APP_KEY"]

      @from         = args[:from]
      @to           = args[:to]
      @query        = args[:query]
      @metric_name  = args[:metric]
      @points       = args[:points]
      @host_name    = args[:server]
      @tags         = args[:tags]
      @message      = args[:message]
      
    end
    
    def dog
      Dogapi::Client.new(@api_key, @app_key)
    end
    
    def get_metrics(from, to, query)
      RestClient.get 'https://app.datadoghq.com/api/v1/query', {
        :params => {
          :api_key => @api_key,
          :application_key => @app_key,
          :from => from,
          :to => to,
          :query => query
        }
      }
    end
    
    def put_metrics(metric_name, points, host_name)
      dog.emit_point(metric_name, points, :host => host_name)
    end

    def metrics
      if @metric_name && @host_name && @points
        put_metrics(@metric_name, @points, @host_name)
      elsif @from && @to && @query
        get_metrics(@from, @to, @query)
      end
    end

    def tags
      if !@host_name 
        # Get all tags
        result = dog.all_tags()
        result[1].to_json
      elsif @host_name && @query == "detach"
        # Detach all tags
        result = dog.detach_tags(@host_name)
        result[1].to_json
      else
        unless @tags
          # Get host tags
          result = dog.host_tags(@host_name)
          result[1].to_json
       else
          # Add host tags
          tags = @tags.split(",")
          result = dog.add_tags(@host_name, tags)
          result[1].to_json
       end
     end
    end

    def search
      result = dog.search(@query)
      result[1].to_json
    end

    def mute_host
      # I'll change @query to @action
      if !@message && @host_name && @query == "unmute"
        result = dog.unmute_host(@host_name)
        result[1].to_json
      elsif @message && @host_name && @to
        result = dog.mute_host(@host_name, :message => @message, :end => @to)
        result[1].to_json
      end
    end

  end
end
