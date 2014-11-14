require 'coveralls'           # must be before everything else
Coveralls.wear!

require 'minitest/autorun'
require 'mocha/setup'         # must be after require 'minitest/autorun'

require_relative '../lib/roughgem'
