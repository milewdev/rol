# Eat warning messages emitted when coveralls loaded.
# See http://devblog.avdi.org/2011/08/25/temporarily-disabling-warnings-in-ruby/
begin
  require 'stringio'
  $stderr, original_stderr = StringIO.new, $stderr
  require 'coveralls'         # must be before everything else
  Coveralls.wear!
ensure
  $stderr = original_stderr
end

require 'minitest/autorun'
require 'mocha/setup'         # must be after require 'minitest/autorun'
require 'pry'

require_relative '../lib/rol'
