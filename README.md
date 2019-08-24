# KubsCLI

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/kubs/cli`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Prerequisites

Ruby 2.0+ (Tested with 2.6.[2-3])

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'kubs_cli'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install kubs_cli

## Usage

```bash
gem install kubs_cli
kubs -v # version
kubs init # Creates a $HOME/.kubs directory
kubs install # Installs items as defined by $HOME/.kubs/dependencies.yaml
kubs copy # Copies from $HOME/config-files/(dotfiles|gnome-terminal-settings) to $HOME
kubs pull # Copes from $HOME/.(dotfiles) to $HOME/config-files(dotfiles|gnome-terminal-settings)
kubs git_pull
kubs git_push
```

### Extending

The `$HOME/.kubs` is a good directory to check out

The `$HOME/.kubs/dependencies.yaml` is structed to be extended without updating my gem

### Messing with docker

```bash
docker build --tag=kubs-cli .
docker run -it kubs-cli /bin/bash
```

## Testing

```bash
bundle install
bundle exec rake spec

# OR

bundle exec rspec
```

### Testing in docker

```bash
docker build --tag=kubs-cli .
docker run -it kubs-cli /bin/bash
bundle exec rspec

# OR

bundle exec rake spec
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ParamagicDev/kubs_cli.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
