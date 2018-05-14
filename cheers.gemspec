# -*- encoding: utf-8 -*-
require File.expand_path('../lib/cheers/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ['Mārtiņš Spilners']
  gem.email         = ['martins@eet.nu']
  gem.description   = %q{Cheers randomly generates user avatars from a set of colors and image components.}
  gem.summary       = %q{Generate random user avatars.}
  gem.homepage      = 'http://github.com/eet-nu/cheers'

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = 'cheers'
  gem.require_paths = ['lib']
  gem.version       = Cheers::VERSION
  
  gem.add_dependency 'mini_magick'
end
