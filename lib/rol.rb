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
    add_members(object, hash)
    object
  end

  def self.add_members(object, hash)
    hash.each_pair { |name, value| add_member(object, name, value) }
  end

  def self.add_member(object, name, value)
    if value.is_a? Proc
      add_method_member(object, name, value)
    else
      add_attribute_member(object, name, value)
    end
  end

  def self.add_method_member(object, method_name, proc)
    object.define_singleton_method(method_name) do |*args|
      object.instance_exec(*args, &proc)
    end
  end

  def self.add_attribute_member(object, attribute_name, value)
    check_attribute_name(attribute_name)
    instance_variable_name = build_instance_variable_name(attribute_name)
    add_attribute_getter_method(object, attribute_name, instance_variable_name)
    add_attribute_setter_method(object, attribute_name, instance_variable_name)
    initialize_attribute(object, instance_variable_name, value)
  end

  def self.check_attribute_name(attribute_name)
    raise_ends_with_equals_argument_error(attribute_name) if attribute_name.to_s.end_with?('=')
  end

  def self.raise_ends_with_equals_argument_error(attribute_name)
    raise ArgumentError.new("rol(hash): attribute name '#{attribute_name}' must not end with =")
  end

  def self.build_instance_variable_name(attribute_name)
    "@#{attribute_name}".to_sym
  end

  def self.add_attribute_getter_method(object, attribute_name, instance_variable_name)
    object.define_singleton_method(attribute_name) do
      instance_variable_get(instance_variable_name)
    end
  end

  def self.add_attribute_setter_method(object, attribute_name, instance_variable_name)
    method_name = "#{attribute_name}="
    object.define_singleton_method(method_name) do |value|
      instance_variable_set(instance_variable_name, value)
    end
  end

  def self.initialize_attribute(object, instance_variable_name, value)
    object.instance_variable_set(instance_variable_name, value)
  end
end
