module DatadogApiClient
  class DdApiClient
    
    def initialize(args)
      require 'dogapi'
      require 'json'
      require 'rest-client'
      require 'date'
      require 'time'
      require 'optparse'

      @api_key = ENV["DATADOG_API_KEY"]
      @app_key = ENV["DATADOG_APP_KEY"]

      @from    = args[:from]
      @to      = args[:to]
      @query   = args[:query]

    end
    
    def dog
      Dogapi::Client.new(@api_key, @app_key)
    end
    
    def get_metrics
      RestClient.get 'https://app.datadoghq.com/api/v1/query', {
        :params => {
          :api_key => api_key,
          :application_key => app_key,
          :from => option[:from],
          :to => option[:to],
          :query => option[:query]
        }
      }
    end
    
    def put_metrics
    end

    def search
      result = dog.search(@query)
      result[1].to_json
    end

  end
end
