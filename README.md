# Purgeable

Purge contents from shared caches easily by sending a HTTP method "PURGE".

## Installation

This is a Ruby GEM and may be installed with the command below:

```bash
$ gem install purgeable
```

## Configuration

Configuration file structure:

```yaml
# ./purgeable.yml
sample: &sample
  http_cache:
    - resource_hosts:
        - "www.example.com"
        - "www2.example.com"
      cache_locations:
        - "varnish1.example.com"
        - "varnish2.example.com"
    - resource_hosts:
        - "www3.example.com"
        - "www4.example.com"
      cache_locations:
        - "varnish3.example.com"
        - "varnish4.example.com"

production:
  <<: *sample
```

Configuration load example:

```ruby
Purgeable.load_settings("./purgeable.yml", "production")
```

## Rails generators

Rails 2 generator:

```bash
$ script/generate purgeable_install
      create  config/purgeable.yml
```

Rails 3 generator:

```bash
$ script/rails generate purgeable:install
      create  config/purgeable.yml
```

## Usage

Simple usage:

```ruby
client = Purgeable::Client.new
urls = %w[
  http://www.example.com/article/my-example
  http://www3.example.com/article/id/1234
]
client.purge(urls)  # => {
                    #      "http://www.example.com/article/my-example" => {
                    #          "varnish1.example.com" => #<Net::HTTPOK 200 Purged readbody=true>,
                    #          "varnish2.example.com" => #<Net::HTTPOK 200 Purged readbody=true>
                    #        },
                    #      "http://www3.example.com/article/id/1234" => {
                    #          "varnish3.example.com" => #<Net::HTTPOK 200 Purged readbody=true>,
                    #          "varnish4.example.com" => #<Net::HTTPOK 200 Purged readbody=true>
                    #        },
                    #    }
```

Model helpers usage:

```ruby
class Article < ActiveRecord::Base
  include Purgeable::HttpResource

  def resource_url
    "http://www3.example.com/article/id/#{id}"
  end

  http_purge { "http://www.example.com/article/#{friendly_title}" }
  http_purge :resource_url

  after_save :perform_purge  # send the HTTP PURGE to configured caches on save
end
```

Enjoy it.
