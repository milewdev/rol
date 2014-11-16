require_relative '../test_helper'

# #
# # o = rol({
# #   sum: @sum,
# #   initialize: -> { @sum = 0 },
# #   add: -> (amount) { @sum += amount }
# # })
# # puts o.sum    # 0
# # o.add(3)
# # puts o.sum    # 3
# #
# describe 'what is rol()' do
#   it 'provides a shorthand way to create an object on the fly'
# end


#
# o = rol()   # o is an instance of Object
#
describe 'rol() return value' do
  before do
    @o = rol()
  end
  it 'returns an instance of Object' do
    @o.class.must_equal Object
  end
end


#
# o = rol()   # returns an instance of Object with no additional methods or attributes
#
describe 'rol() with no arguments' do
  before do
    @o = rol()
    @vanila = Object.new
  end
  it 'allows nothing to be defined' do
    @o.wont_be_nil
  end
  it 'returns an instance of Object with no additional attributes or methods' do
    @o.methods.must_equal @vanila.methods
    @o.instance_variables.must_equal @vanila.instance_variables
  end
end


#
# o =rol({ x: 42 })
# puts o.x            # 42
# o.x = 43            # raises NoMethodError: x=
#
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


#
# o = rol({ name: 'Fluffy', age: 3 })
# puts o.name         # Fluffy
# puts o.age          # 3
# o.age = 4           # raises NoMethodError: age=
#
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


#
# TODO: what does rol({ UPPER_CASE: 42 }) mean?
#


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
