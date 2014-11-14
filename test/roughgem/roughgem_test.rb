require_relative '../test_helper'

module RoughGem
  describe RoughGem do
    it "says 'Hello, RoughGem'" do
      proc do
        @argv = []
        RoughGem.run(@argv)
      end.must_output "Hello, RoughGem\n"
    end
  end
end
