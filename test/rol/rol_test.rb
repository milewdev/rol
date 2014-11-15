require_relative '../test_helper'

module Rol
  describe Rol do
    it 'returns an object with the specified attribute' do
      o = Rol.rol({ x: 'a' })
      o.x.must_equal 'a'
    end
  end
end
