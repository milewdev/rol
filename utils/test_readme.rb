#
# Ruby script that scans a file for github-style embedded Ruby code blocks,
# executes each block, and verifies that the output to $stdout matches the
# expected output as specified in comments in the block.  It was written to
# verify the Ruby code in a project's README.md file but can be used with
# any file.
#
# For example, consider the following README.md:
#
#   Methods can also be defined:
#
#   ```ruby
#   require 'date'
#   require 'rol'
#   today = rol({ formatted: -> { Date.new(2014,11,24).strftime('%Y.%m.%d') } })
#   puts today.formatted  # => 2014.11.24
#   ```
#
#   Methods can take arguments:
#
#   ```ruby
#   require 'rol'
#   friendly = rol({ greet: -> (name) { "Hi #{name}!" } })
#   puts friendly.greet('Spot')   # => Hi Spot!
#   ```
#
# The embedded Ruby code in README.md is verified as follows:
#
#   $ ruby test_readme.md README.md
#
# This script will extract the two embedded blocks of code and verify that
# the first outputs '2014.11.14' and that the second outputs 'Hi Spot!'.
#
# The program entry point is the last line of this file.
#

def main(argv)
  check_args(argv)
  input_filename = argv[0]
  contents = read_input_filename(input_filename)
  find_ruby_code_blocks(contents).each { |ruby_code| verify_ruby_code_output(ruby_code) }
end

def check_args(argv)
  input_filename = argv[0]
  abort "usage: #{$PROGRAM_NAME} README.md" unless ARGV.length == 1
  abort "error: file #{input_filename} not found" unless File.exist?(input_filename)
  abort "error: #{input_filename} is not a file}" unless File.file?(input_filename)
end

def read_input_filename(input_filename)
  require 'stringio'
  IO.read(input_filename)
end

#
# Given the contents:
#   some text
#   ```ruby
#   x = 1
#   puts x  # => 1
#   ```
#   some text
#   ```ruby
#   puts 2  # => 2
#   ```
#   some text
#
# this method returns:
#  ["x = 1\nputs 1  # => 1\n", "puts 2  # => 2\n"]
#
def find_ruby_code_blocks(contents)
  contents.scan( /```ruby\n(.*?)```/m ).flatten
end

def verify_ruby_code_output(ruby_code)
  expected_output = find_expected_output(ruby_code)
  actual_output = run_ruby_code(ruby_code)
  return if expected_output == actual_output
  report_unexpected_output(expected_output, actual_output, ruby_code)
end

#
# Given the Ruby code:
#   puts a  # => 0
#   puts b  # => 1
#
# this method returns:
#   "0\n1\n"
#
def find_expected_output(ruby_code)
  ruby_code.scan( /# => (.*?)\n/m ).flatten.join("\n") + "\n"
end

#
# run_ruby_code("x = 123\nputs x") => "123\n"
#
def run_ruby_code(ruby_code)
  $stdout, original_stdout = StringIO.new, $stdout
  eval(ruby_code)
  $stdout.string
ensure
  $stdout = original_stdout
end

def report_unexpected_output(expected_output, actual_output, ruby_code)
  $stderr.puts "Expected:\n  #{expected_output.split("\n").join("\n  ")}"
  $stderr.puts "Actual:\n  #{actual_output.split("\n").join("\n  ")}"
  $stderr.puts "Code:\n  #{ruby_code.split("\n").join("\n  ")}\n\n"
end

main(ARGV)
