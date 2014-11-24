#
# Save some typing by making rol() syntactic sugar for Rol.rol()
#
module Kernel
  def rol(*args)
    Rol.rol(*args)
  end
end
