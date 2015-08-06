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

### Set API key and APP key

```sh
$ export DATADOG_API_KEY=<your_api_key>
$ export DATADOG_APP_KEY=<your_app_key>
```

### Command line help

```sh
$ bundle exec ruby bin/datadog-api-client.rb -h
Usage: datadog-api-client [options]
    -e, --endpoint=NAME              API Endpoint Name. ex: metric ... Please see http://docs.datadoghq.com/ja/api/
    -f, --from=VALUE                 From Epoch Time. ex: `date -d '5 minutes ago' +%s`
    -t, --to=VALUE                   To Epoch Time. ex: `date +%s`
    -q, --query=VALUE                Query String. ex: system.cpu.idle{*}by{host}
    -m, --metric=NAME                Metric Name. ex: some.metric.name
    -p, --points=VALUE               Metric Value or Values. ex: 12345 or [[POSIX_timestamp, numeric_value]]
    -s, --server=Name                Host Name. ex: foo.example.com
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

### Post metrics(Post time series points)

```sh
$ bundle exec ruby bin/datadog-api-client.rb \
  -e metrics \ 
  -m foo.bar.baz \
  --host=host01 \
  -p $RANDOM
```

output.

```sh
202
{"status"=>"ok"}
```

dashboard.

![dashboard](https://raw.githubusercontent.com/inokappa/datadog-api-client/master/images/2015080601.png)

### Fetch metrics(Query time series points)

```sh
$ bundle exec ruby bin/datadog-api-client.rb \
  -e metrics \
  -f `date -d '10 minutes ago' +%s` \
  -t `date +%s` -q foo.bar.baz{host:host01} \
| python -m json.tool
``

output(Does not include poinits).

```javascript
{
    "from_date": 1438868623000,
    "group_by": [],
    "message": "",
    "query": "foo.bar.baz{host:host01}",
    "res_type": "time_series",
    "series": [],
    "status": "ok",
    "to_date": 1438869223000
}
```

output(Include poinits).

```javascript
{
    "from_date": 1438867504000,
    "group_by": [],
    "message": "",
    "query": "foo.bar.baz{host:host01}",
    "res_type": "time_series",
    "series": [
        {
            "aggr": null,
            "attributes": {},
            "display_name": "foo.bar.baz",
            "end": 1438868579000,
            "expression": "foo.bar.baz{host:host01}",
            "interval": 20,
            "length": 2,
            "metric": "foo.bar.baz",
            "pointlist": [
                [
                    1438868480000.0,
                    19942.0
                ],
                [
                    1438868560000.0,
                    16738.0
                ]
            ],
            "scope": "host:host01",
            "start": 1438868480000,
            "unit": [
                null,
                null
            ]
        }
    ],
    "status": "ok",
    "to_date": 1438869304000
}
```

***

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/datadog_api_client.

