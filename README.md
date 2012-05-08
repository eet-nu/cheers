Cheers
======

Cheers randomly generates user avatars from a set of colors and image components.

## Installation

Add this line to your application's Gemfile:

    gem 'cheers'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cheers

## Usage

````ruby
avatar = Cheers::Avatar.new("martins@eet.nu")
avatar.avatar_file("avatar.png")
````

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
