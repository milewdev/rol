require_relative '../test_helper'


# describe 'what is rol()' do
#   before do
#     @o = rol({
#       name: 'Fluffy',
#       greet: -> (your_name) { "Hi #{your_name}!  My name is #{name}!" }
#     })
#   end
#   it 'provides a shorthand way to create an object on the fly' do
#     @o.greet('Spot').must_equal 'Hi Spot! name is Fluffy!'
#   end
# end


describe 'rol() return value' do
  before do
    @o = rol()
  end
  it 'returns an instance of Object' do
    @o.class.must_equal Object
  end
end


describe 'rol() with no arguments' do
  before do
    @o = rol()
    @vanila_object = Object.new
  end
  it 'returns an object' do
    @o.wont_be_nil
  end
  it 'returns an instance of Object with no additional attributes or methods' do
    @o.methods.must_equal @vanila_object.methods
    @o.instance_variables.must_equal @vanila_object.instance_variables
  end
end


describe 'rol() attribute definition' do
  before do
    @o = rol({ x: 42})
  end
  it 'allows an attribute to be defined' do
    @o.methods.must_include :x
  end
  it 'preserves the type of the attribute' do
    @o.x.class.must_equal 42.class
  end
  it 'preserves the value of the attribute' do
    @o.x.must_equal 42
  end
  it 'defines the attribute as read-only' do
    @o.methods.wont_include :x=
  end
end


describe 'rol() multiple attribute definitions' do
  before do
    @o = rol({ a_number: 1, a_boolean: true, a_string: 'hi' })
  end
  it 'allows many attributes to be defined' do
    @o.methods.must_include :a_number
    @o.methods.must_include :a_boolean
    @o.methods.must_include :a_string
  end
  it 'preserves the type of each attribute' do
    @o.a_number.class.must_equal 1.class
    @o.a_boolean.class.must_equal true.class
    @o.a_string.class.must_equal 'hi'.class
  end
  it 'preserves the value of each attribute' do
    @o.a_number.must_equal 1
    @o.a_boolean.must_equal true
    @o.a_string.must_equal 'hi'
  end
  it 'defines each attribute as read-only' do
    @o.methods.wont_include :a_number=
    @o.methods.wont_include :a_boolean=
    @o.methods.wont_include :a_string=
  end
end


describe 'rol() argument validation' do
  it 'raises an exception when the argument does not respond to #each_pair' do
    exception = proc { rol([1,2,3]) }.must_raise ArgumentError
    exception.message.must_equal "rol(hash): 'hash' argument must respond to #each_pair"
  end
end


describe 'rol() attribute definition' do
  before do
    @o = rol({ Capitalized: 42 })
  end
  it 'allows capitalized attribute names' do
    @o.methods.must_include :Capitalized
  end
end


describe 'rol() attribute names' do
  before do
    @attribute_name = '~`1!2@3#4$5%6^7&8*9(0)-_=+{[]}|\:;<,>.?/'
    @o = rol({ @attribute_name => 42 })
  end
  it 'does not do any validation of attribute names' do
    @o.methods.must_include @attribute_name.to_sym
  end
end


describe 'rol() method definition' do
  before do
    @o = rol({ my_method: -> (x) { x * 2 } })
  end
  it 'allows a method to be defined' do
    @o.methods.must_include :my_method
  end
  it 'defines the method as read-only' do
    @o.methods.wont_include :my_method=
  end
  it 'defines a method that can actually be called' do
    @o.my_method(3).must_equal 6
  end
end


describe 'rol() method definition' do
  before do
    @o = rol({
      height: 2,
      width: 3,
      area: -> { height * width }
    })
  end
  it 'invokes the method in the context of the object' do
    @o.area.must_equal 6
  end
end


#
# Provide Kernel.rol() as an alias for Rol.rol():
#
#   o = Rol.rol({ x: 42 })
#   o = rol({ x: 42 })      # easier to read, faster to write
#   o = %o({ x: 42 })       # would be nicer still
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
