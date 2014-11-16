# 'require' all files except ourselves.
me = File.absolute_path(__FILE__)
Dir.glob(File.dirname(me) + '/**/*.rb') {|fn| require fn unless fn == me }

module Kernel
  def rol(*args)
    Rol.rol(*args)
  end
end

module Rol
  def self.rol(hash = {})
    raise ArgumentError.new("rol(hash): 'hash' argument must respond to #each_pair") unless hash.respond_to?(:each_pair)
    o = Object.new
    hash.each_pair do |key, value|
      # TODO: need to check what happens if either key or value is invalid.
      o.define_singleton_method(key) { value }
    end
    o
  end
end
