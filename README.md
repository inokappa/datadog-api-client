# DatadogApiClient

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'datadog_api_client'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install datadog_api_client

## Usage

### Set API Key and APP Key

```sh
$ export DATADOG_API_KEY=<your_api_key>
$ export DATADOG_APP_KEY=<your_app_key>
```

### Get available host list

```sh
$ bundle exec ruby bin/datadog-api-client.rb -e search -q hosts: | python -m json.tool
```

output.

```javascript
{
    "results": {
        "hosts": [
            "host01",
            "host02"
        ]
    }
}
```

### Get available metrics List

```sh
$ bundle exec ruby bin/datadog-api-client.rb -e search -q metrics: | python -m json.tool
```

output.

```javascript
{
    "results": {
        "metrics": [
            "datadog.agent.emitter.emit.time",
            "ntp.offset",
            "collection_timestamp",
            "datadog.dogstatsd.packet.count",
            "docker.containers.running",
(snip)
            "system.swap.used",
            "system.uptime"
        ]
    }
}
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/datadog_api_client.

