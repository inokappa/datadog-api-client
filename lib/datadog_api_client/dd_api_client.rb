module DatadogApiClient
  class DdApiClient
    
    def initialize(args)
      require 'dogapi'
      require 'json'
      require 'rest-client'
      require 'date'
      require 'time'
      require 'optparse'

      @api_key      = ENV["DATADOG_API_KEY"]
      @app_key      = ENV["DATADOG_APP_KEY"]

      @from         = args[:from]
      @to           = args[:to]
      @query        = args[:query]
      @metric_name  = args[:metric]
      @points       = args[:points]
      @host_name    = args[:server]

    end
    
    def dog
      Dogapi::Client.new(@api_key, @app_key)
    end
    
    def get_metrics
      result = RestClient.get 'https://app.datadoghq.com/api/v1/query', {
        :params => {
          :api_key => @api_key,
          :application_key => @app_key,
          :from => @from,
          :to => @to,
          :query => @query
        }
      }
    end
    
    def put_metrics
      dog.emit_point(@metric_name, @points, :host => @host_name)
    end

    def search
      result = dog.search(@query)
      result[1].to_json
    end

  end
end
