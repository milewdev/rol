require_relative '../test_helper'


#
# In the various tests below, we add various methods to an instance
# of Object.  Here we ensure Object does not already have those
# methods.
#
describe 'assumptions about Object' do
  [ :name, :greet, :x, :Capitalized, :first, :second, :third, :my_method, :height, :width, :area ].each do |name|
    it "does not have an attribute called :#{name}" do
      Object.new.instance_variables.wont_include name
    end
    it "does not have a method called :#{name}" do
      Object.new.methods.wont_include name
    end
    it "does not have a method called :#{name}=" do
      Object.new.methods.wont_include "#{name}=".to_sym
    end
  end
end


#
# What does rol do?
#
describe 'rol()' do
  it 'provides a shorthand way to create an object on the fly' do
    object = rol({
      name: 'Fluffy',
      greet: -> (your_name) { "Hi #{your_name}! My name is #{@name}!" }
    })
    object.greet('Spot').must_equal 'Hi Spot! My name is Fluffy!'
  end
end


#
# How do I find the rol version?
#
describe 'Rol.Version' do
  it 'returns the rol() version' do
    Rol::Version.must_equal '0.0.2'
  end
end


#
# What arguments does rol take and what restrictions do they have?
#
describe 'arguments' do
  it 'expects one argument that behaves like a hash' do
    rol({ x: 42 })
  end
  it 'raises an exception when the argument does not respond to #each_pair' do
    exception = proc { rol([1,2,3]) }.must_raise ArgumentError
    exception.message.must_equal "rol(hash): 'hash' argument must respond to #each_pair"
  end
  it 'raises an exception when called with more than one argument' do
    exception = proc { rol({}, 42) }.must_raise ArgumentError
    exception.message.must_equal 'wrong number of arguments (2 for 0..1)'
  end
  it 'does not raise an exception when called with no arguments' do
    rol()
  end
end


#
# What does rol return?
#
describe 'return value' do
  it 'returns an instance of Object' do
    rol().class.must_equal Object
  end
  it 'returns an instance of Object with no additional methods when no arguments are supplied' do
    rol().methods.must_equal Object.new.methods
  end
  it 'returns an instance of Object with no additional methods when an empty hash is supplied' do
    rol({}).methods.must_equal Object.new.methods
  end
end


#
# What happens when I define an attribute?
#
describe 'defining an attribute' do
  before do
    @object = rol({ x: 42 })
  end
  it 'creates the attribute' do
    @object.instance_variables.must_include :@x
  end
  it 'creates a get method for the attribute' do
    @object.methods.must_include :x
  end
  it 'creates a set method for the attribute' do
    @object.methods.must_include :x=
  end
  it 'sets the initial value of the attribute' do
    @object.instance_variable_get(:@x).must_equal 42
  end
end


#
# What does the get method for an attribute do?
#
describe 'attribute get method' do
  it 'returns the value of the attibute' do
    @object = rol({ x: 42 })
    @object.x.must_equal 42
  end
end


#
# What does the set method for an attribute do?
#
describe 'attribute set method' do
  it 'sets the value of the attribute' do
    @object = rol({ x: 42 })
    @object.x = 24
    @object.instance_variable_get(:@x).must_equal 24
  end
end


#
# What are the restrictions on attribute names?
#
describe 'attribute names' do
  it 'allows capitalized attribute names' do
    rol({ Capitalized: 42 }).methods.must_include :Capitalized
  end
  it 'raises an exception if the attribute name ends with =' do
    exception = proc { rol({ 'name=' => 42 }) }.must_raise ArgumentError
    exception.message.must_equal "rol(hash): attribute name 'name=' must not end with ="
  end
end


#
# Can I define more than one attribute?
#
describe 'multiple attribute definitions' do
  it 'allows many attributes to be defined' do
    object = rol({ first: 1, second: 2, third: 3 })
    object.methods.must_include :first
    object.methods.must_include :second
    object.methods.must_include :third
  end
end


#
# What happens when I define a method?
#
describe 'method definition' do
  before do
    @object = rol({ my_method: -> (x) { x * 2 } })
  end
  it 'allows a method to be defined' do
    @object.methods.must_include :my_method
  end
  it 'defines the method as read-only' do
    @object.methods.wont_include :my_method=
  end
  it 'defines a method that can actually be called' do
    @object.my_method(3).must_equal 6
  end
end


#
# What are the restrictions on method names?
#
describe 'method names' do
  it 'does not raise an exception if the method name ends with =' do
    rol({ 'name=' => -> {} })
  end
end


#
# Can methods access attributes?
#
describe 'method invocation' do
  it 'invokes the method in the context of the object' do
    object = rol({
      height: 2,
      width: 3,
      area: -> { @height * @width }   # @height and @width must be accessible
    })
    object.area.must_equal 6
  end
end


#
# Provide Kernel.rol() as an alias for Rol.rol():
#
#   o = Rol.rol({ x: 42 })
#   o = rol({ x: 42 })      # easier to read, faster to write
#   o = %o{ x: 42 }         # would be nicer still
#
describe 'Kernel.rol()' do
  it 'is defined' do
    Kernel.methods.must_include :rol
  end
  it 'invokes Rol.rol()' do
    Rol.expects(:rol)
    rol()
  end
  it 'blindly forwards any and all arguments it was called with along to Rol.rol()' do
    Rol.expects(:rol).with('hello', 'doctor', 'name', 'continue', 'yesterday', 'tomorrow')
    rol('hello', 'doctor', 'name', 'continue', 'yesterday', 'tomorrow')
  end
  it 'passes nothing to Rol.rol() when called with no arguments' do
    Rol.expects(:rol).with()
    rol()
  end
end
