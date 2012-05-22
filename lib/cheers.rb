$LOAD_PATH << File.expand_path('../', __FILE__)

module Cheers
  autoload :VERSION, 'cheers/version'
  autoload :Color,   'cheers/color'
  autoload :Avatar,  'cheers/avatar'
end
