require_relative '../test_helper'

module Rol
  describe Rol do
    it "says 'Hello, rol'" do
      proc do
        @argv = []
        Rol.run(@argv)
      end.must_output "Hello, rol\n"
    end
  end
end
