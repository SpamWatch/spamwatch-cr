# spamwatch.cr

Crystal adapter to the [SpamWatch](https://spamwat.ch) API

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     spamwatch:
       github: spamwatch/spamwatch-cr
   ```

2. Run `shards install`

## Usage

```crystal
require "spamwatch"

token = ENV["SPAMWATCH_TOKEN"]
client = SpamWatch::Client.new(token)

me  = client.get_self
ban = client.get_ban(835061938)
```

## Contributing

1. Fork it (<https://github.com/spamwatch/spamwatch-cr/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Chris Watson](https://github.com/spamwatch) - creato-crr and maintainer
