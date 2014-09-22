# Capistrano::Hutch

[Hutch](https://github.com/gocardless/hutch) integration for [Capistrano 3](https://github.com/capistrano/capistrano)

## Installation

Add this line to your application's Gemfile:

    gem 'capistrano-hutch'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install capistrano-hutch

## Usage

Add to your Capfile

    require 'capistrano/hutch'

Do not forget to create `config/hutch.yml` on production host and setup symlink.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/capistrano-hutch/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
