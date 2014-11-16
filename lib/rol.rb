# 'require' all files except ourselves.
me = File.absolute_path(__FILE__)
Dir.glob(File.dirname(me) + '/**/*.rb') {|fn| require fn unless fn == me }

module Kernel
  def rol(*args)
    Rol.rol(*args)
  end
end

module Rol
  def self.rol(hash = nil)
    # TODO: need to check the type of hash; must be a hash
    o = Object.new
    if hash   # TODO: use 'hash = {}' in the arg list instead
      hash.each do |key, value|
        o.define_singleton_method(key) { value }
      end
    end
    o
  end
end
