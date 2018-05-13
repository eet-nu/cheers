require 'mini_magick'
require 'digest/sha1'
require 'tempfile'

module Cheers
  class Avatar

    BACKGROUND_COLORS = %w(#cccccc #dddddd #bbbbbb #f1a800 #fef0cc
                           #fd4238 #fff0f0 #14899d #c3ecee #42991a
                           #f0fff0)
    
    COMPONENT_COLORS   = %w(#333333 #666666 #9e005d #ef8200 #db4640
                            #0e788b #239340)
    
    # Creates a new avatar from the seed string
    def initialize(seed)
      @seed = Digest::SHA1.hexdigest(seed).to_i(16)
    end
    
    # Writes avatar image at the provided file path
    def avatar_file(file_path)
      avatar = compose_avatar
      
      avatar.write(file_path)

      file_path
    end
    
    # Returns a binary version of the image
    def to_blob(format)
      compose_avatar
      
      @avatar.format = format
      @avatar.to_blob
    end
    
    private
    
    def compose_avatar #:nodoc:
      generator = Random.new(@seed)

      result = nil
      [Background, Face, Decoration, Eyes].each do |klass|
        result = klass.new(result, generator).apply
      end

      result
    end
  end
end
