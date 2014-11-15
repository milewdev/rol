# 'require' all files except ourselves.
me = File.absolute_path(__FILE__)
Dir.glob(File.dirname(me) + '/**/*.rb') {|fn| require fn unless fn == me }

module Rol
  def self.rol(hash)
    o = Object.new
    class << o
      def x
        'a'
      end
    end
    o
  end
end
