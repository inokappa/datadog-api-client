# Hachiko

## About

### Hachiko is ...

Yet another Datadog API Client.

### Supported API Endpoint

- [Search](http://docs.datadoghq.com/ja/api/#search)
- [Metrics](http://docs.datadoghq.com/ja/api/#metrics)
- [Tags](http://docs.datadoghq.com/ja/api/#tags)
- [Hosts](http://docs.datadoghq.com/ja/api/#hosts)

***

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hachiko'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hachiko

***

## Usage

### Set API key and APP key

```sh
$ export DATADOG_API_KEY=<your_api_key>
$ export DATADOG_APP_KEY=<your_app_key>
```

### Command line help

```sh
$ bundle exec ./bin/hachiko -h
Usage: hachiko [options]
    -e, --endpoint=NAME              API Endpoint Name. ex: metrics or search ... Please see http://docs.datadoghq.com/ja/api/
        --from=VALUE                 From Epoch Time. ex: `date -d '5 minutes ago' +%s`
        --to=VALUE                   To Epoch Time. ex: `date +%s`
    -q, --query=VALUE                Query String. ex: system.cpu.idle{*}by{host}
    -m, --metric=NAME                Metric Name. ex: some.metric.name
    -p, --points=VALUE               Metric Value or Values. ex: 12345 or [[POSIX_timestamp, numeric_value]]
    -s, --server=Name                Host Name. ex: foo.example.com
    -t, --tags=Tag Names             Tag Name or Names. ex: role:foo or role:foo,role:bar
```

### Get available host list

```sh
$ bundle exec ruby bin/hachiko -e search -q hosts: | python -m json.tool
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
$ bundle exec ruby bin/hachiko -e search -q metrics: | python -m json.tool
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
$ bundle exec ruby bin/hachiko \
  -e metrics \ 
  -m foo.bar.baz \
  --server=host01 \
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
$ bundle exec ruby bin/hachiko \
  -e metrics \
  --from `date -d '10 minutes ago' +%s` \
  --to `date +%s` -q foo.bar.baz{host:host01} \
| python -m json.tool
```

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

### Get tags and Get host tags

Get all tags.

```sh
$ bundle exec ./bin/hachiko -e tags | python -m json.tool
```

output.

```javascript

{
    "tags": {
        "role:bar": [
            "host01",
            "host02"
        ],
        "role:baz": [
            "host01",
            "host02"
        ],
        "role:foo": [
            "host01",
            "host02"
        ]
    }
}
```

Get host tags.

```sh
bundle exec ./bin/hachiko -e tags -s host01 | python -m json.tool
```

output.

```javascript
{
    "tags": [
        "role:foo",
        "role:bar",
        "role:baz"
    ]
}
```

### Add host tags

```sh
bundle exec ./bin/hachiko -e tags -s host01 -t role:foo,role:bar,role:baz | python -m json.tool
```

output.

```javascript
{
    "host": "host01",
    "tags": [
        "role:foo",
        "role:bar",
        "role:baz"
    ]
}
```

### Delete host tags

```sh
bundle exec ./bin/hachiko -e tags -s host01 -q detach 
```

output.

```javascript
{}
```

### Mute a host

```sh
$ bundle exec ruby bin/hachiko -e hosts --server=host01 --message="Mute test" --to `date -d '5 minutes' +%s` | jq .
```

output.

```javascript
{
  "end": 1438915377,
  "hostname": "host01",
  "message": "Mute test",
  "action": "Muted"
}

```

### Unmute a host

```sh
$ bundle exec ruby bin/hachiko -e hosts --server=host01 --query=unmute | jq .
```

output.

```javascript
{
  "hostname": "host01",
  "action": "Unmuted"
}
```

***

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/hachiko.

