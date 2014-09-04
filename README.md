# Scafld

A simple token replacement template engine. (Yes a fancy way of writing a regexp wrapper).

## Installation

Add this line to your application's Gemfile:

    gem 'scafld'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install scafld

## Usage

Scafld exposes two metods:

    Scafld.from_s("some string with {{tokens}}")
    Scafld.from_file("some-file.txt")

## Contributing

1. Fork it ( http://github.com/mkrogh/scafld/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
