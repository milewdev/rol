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
    check_arg(hash)
    build_object(hash)
  end

  private

  def self.check_arg(hash)
    raise_not_a_hash_argument_error unless hash.respond_to?(:each_pair)
  end

  def self.raise_not_a_hash_argument_error
    raise ArgumentError.new("rol(hash): 'hash' argument must respond to #each_pair")
  end

  def self.build_object(hash)
    object = Object.new
    hash.each_pair do |key, value|
      if value.is_a? Proc
        object.define_singleton_method(key) { |*args| object.instance_exec(*args, &value) }
      else
        object.define_singleton_method(key) { value }
      end
    end
    object
  end
end
