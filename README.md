# Capistrano::Hutch

[Hutch](https://github.com/gocardless/hutch) integration for [Capistrano 3](https://github.com/capistrano/capistrano)

# MAINTAINER NEEDED

## I'm not supporting this project anymore. I suggest you to switch to foreman + capistrano-foreman. Self-daemonization is not a good thing actually. Better way is to use upstart/systemd to run your software. Foreman has export feature. You can export your Procfile and run hutch as system service.

## Installation

Add this lines to your application's Gemfile:

    gem 'hutch', github: 'gocardless/hutch' # currently capistrano-hutch requires HEAD version of hutch.
    gem 'capistrano-hutch', group: :development

And then execute:

    $ bundle

## Usage

```ruby
    # Capfile

    require 'capistrano/hutch'
```

Configurable options, shown here with defaults:

```ruby
    hutch_role:           :app
    hutch_default_hooks:  true
    hutch_pid:            File.join(shared_path, 'tmp', 'pids', 'hutch.pid')
    hutch_config:         File.join(shared_path, 'config', 'hutch.yml')
    hutch_env:            fetch(:rails_env, fetch(:rack_env, fetch(:stage)))
    hutch_options:        nil
```

Do not forget to create `config/hutch.yml` on production host and setup symlink.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/capistrano-hutch/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
