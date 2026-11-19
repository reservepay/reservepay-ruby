# reservepay-ruby

Typed Ruby clients to allow usage of the Reservepay APIs - [Merchant](https://developer.reservepay.com/api/merchants), [SDK](https://developer.reservepay.com/api/sdk)
, and [Terminal](https://developer.reservepay.com/api/terminals).

The clients (found in `lib/reservepay/`, with their [RBS](https://github.com/ruby/rbs) type signatures in `sig/reservepay/`) were generated using the [WebFunction CLI tool](https://github.com/webfunction-protocol/webfunction-cli).

Requires Ruby 3.1 or later.

## Usage

```
gem install reservepay
```

Or add it to your `Gemfile`:

```ruby
gem "reservepay"
```

Each API is in its own module (`Reservepay::Merchant`, `Reservepay::SDK`, `Reservepay::Terminal`), each with a `Client` class. Creating a `Client` returns a fully configured client, ready to access the associated API.

```ruby
require "reservepay"

client = Reservepay::Merchant::Client.new(bearer_auth: "MY_API_KEY")

versions = client.available_api_versions

puts versions.join(", ")
```

The clients wrap the [web_function](https://github.com/robinclart/web_function) gem, which is installed as a dependency.

## Regenerating the clients

`./refresh_clients.sh` regenerates all three clients from the live APIs. It needs the `wfn` tool (set `WFN_PATH` if it is not in your `PATH`).
