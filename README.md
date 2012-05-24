Cheers
======

Cheers randomly generates user avatars from a set of colors and image components.

<img src="https://github.com/eet-nu/cheers/raw/master/doc/example_1.png" alt="Example Avatar #1" width="100" height="100"> 
<img src="https://github.com/eet-nu/cheers/raw/master/doc/example_2.png" alt="Example Avatar #2" width="100" height="100"> 
<img src="https://github.com/eet-nu/cheers/raw/master/doc/example_3.png" alt="Example Avatar #3" width="100" height="100"> 
<img src="https://github.com/eet-nu/cheers/raw/master/doc/example_4.png" alt="Example Avatar #4" width="100" height="100"> 
<img src="https://github.com/eet-nu/cheers/raw/master/doc/example_5.png" alt="Example Avatar #5" width="100" height="100">

<img src="https://github.com/eet-nu/cheers/raw/master/doc/example_6.png" alt="Example Avatar #6" width="75" height="75"> 
<img src="https://github.com/eet-nu/cheers/raw/master/doc/example_7.png" alt="Example Avatar #7" width="75" height="75"> 
<img src="https://github.com/eet-nu/cheers/raw/master/doc/example_8.png" alt="Example Avatar #8" width="75" height="75"> 
<img src="https://github.com/eet-nu/cheers/raw/master/doc/example_9.png" alt="Example Avatar #9" width="75" height="75"> 
<img src="https://github.com/eet-nu/cheers/raw/master/doc/example_10.png" alt="Example Avatar #10" width="75" height="75">

<img src="https://github.com/eet-nu/cheers/raw/master/doc/example_11.png" alt="Example Avatar #11" width="50" height="50"> 
<img src="https://github.com/eet-nu/cheers/raw/master/doc/example_12.png" alt="Example Avatar #12" width="50" height="50"> 
<img src="https://github.com/eet-nu/cheers/raw/master/doc/example_13.png" alt="Example Avatar #13" width="50" height="50"> 
<img src="https://github.com/eet-nu/cheers/raw/master/doc/example_14.png" alt="Example Avatar #14" width="50" height="50"> 
<img src="https://github.com/eet-nu/cheers/raw/master/doc/example_15.png" alt="Example Avatar #15" width="50" height="50">

<img src="https://github.com/eet-nu/cheers/raw/master/doc/example_16.png" alt="Example Avatar #16" width="25" height="25"> 
<img src="https://github.com/eet-nu/cheers/raw/master/doc/example_17.png" alt="Example Avatar #17" width="25" height="25"> 
<img src="https://github.com/eet-nu/cheers/raw/master/doc/example_18.png" alt="Example Avatar #18" width="25" height="25"> 
<img src="https://github.com/eet-nu/cheers/raw/master/doc/example_19.png" alt="Example Avatar #19" width="25" height="25"> 
<img src="https://github.com/eet-nu/cheers/raw/master/doc/example_20.png" alt="Example Avatar #20" width="25" height="25">

## Installation

Add this line to your application's Gemfile:

    gem 'cheers'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cheers

## Usage

````ruby
require 'cheers'

avatar = Cheers::Avatar.new("martins@eet.nu")
avatar.avatar_file("avatar.png")
````

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
