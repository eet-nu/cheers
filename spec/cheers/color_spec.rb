require 'spec_helper'

describe Cheers::Color do
  describe '#initialize' do
    it 'converts 32 bit hexadecimal color values to RGB' do
      color = Cheers::Color.new('#7d7d7d')
      [color.r, color.g, color.b].should == [125, 125, 125]
    end
  end
  
  describe '#r' do
    it 'returns the intensity of the red component of the color' do
      black = Cheers::Color.new '#000000'
      black.r.should == 0
      
      
      white = Cheers::Color.new '#ffffff'
      white.r.should == 255
      
      red  = Cheers::Color.new '#7d0000'
      red.r.should == 125
    end
  end
  
  describe '#g' do
    it 'returns the intensity of the green component of the color' do
      black = Cheers::Color.new '#000000'
      black.g.should == 0
      
      
      white = Cheers::Color.new '#ffffff'
      white.g.should == 255
      
      green  = Cheers::Color.new '#007d00'
      green.g.should == 125
    end
  end
  
  describe '#b' do
    it 'returns the intensity of the blue component of the color' do
      black = Cheers::Color.new '#000000'
      black.b.should == 0
      
      
      white = Cheers::Color.new '#ffffff'
      white.b.should == 255
      
      blue  = Cheers::Color.new '#00007d'
      blue.b.should == 125
    end
  end
  
  describe '#to_hsv' do
    it 'returns the HSV values for the color' do
      orange  = Cheers::Color.new '#d97621'
      h, s, v = orange.to_hsv
      
      h.should be_within(0.001).of 27.717
      s.should be_within(0.001).of  0.848
      v.should be_within(0.001).of  0.851
    end
  end
  
  describe '#to_s' do
    it 'returns a hexadecimal representation of the color' do
      color = Cheers::Color.new('#00007d')
      color.to_s.should == '#00007d'
    end
  end
  
  describe '#similar?' do
    it 'returns true if the colors are similar' do
      bright_white = Cheers::Color.new '#ffffff'
      broken_white = Cheers::Color.new '#eeeeee'
      
      bright_white.similar?(broken_white).should be_true
      broken_white.similar?(bright_white).should be_true
    end
    
    it 'returns false if the colors are not similar' do
      white = Cheers::Color.new '#ffffff'
      black = Cheers::Color.new '#000000'
      
      white.similar?(black).should be_false
      black.similar?(white).should be_false
    end
    
    it 'returns true if the color is too similar for the given treshold' do
      orange_1 = Cheers::Color.new '#f1a800'
      orange_2 = Cheers::Color.new '#ef8200'
      
      orange_1.similar?(orange_2, 0.02).should be_false
      orange_1.similar?(orange_2, 0.03).should be_true
    end
  end
end
