# ---- requirements
require 'rubygems'
require 'spec'

$LOAD_PATH << File.expand_path("../lib", File.dirname(__FILE__))

# ---- bugfix
#`exit?': undefined method `run?' for Test::Unit:Module (NoMethodError)
#can be solved with require test/unit but this will result in extra test-output
module Test
  module Unit
    def self.run?
      true
    end
  end
end