# 'require' all files except ourselves.
me = File.absolute_path(__FILE__)
Dir.glob(File.dirname(me) + '/**/*.rb') {|fn| require fn unless fn == me }

module Rol

  #
  # Program entry point. Responsible for ...
  # Also responsible for reporting errors.
  #
  def self.run
    puts 'Hello, rol'
  end

end
