require_relative '../test_helper'

describe Rol do
  it 'returns an object with the specified attribute' do
    o = Rol.rol({ x: 'a' })
    o.x.must_equal 'a'
  end
end

#
# Provide Kernel.rol() as an alias for Rol.rol().  rol() is easier to read and
# quicker to write than Rol.rol().
#
describe 'Kernel.rol()' do
  it "is defined" do
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
