[![Gem Version](https://badge.fury.io/rb/rol.svg)](http://badge.fury.io/rb/rol)
[![Build Status](https://travis-ci.org/milewdev/rol.svg?branch=master)](https://travis-ci.org/milewdev/rol)
[![Code Climate](https://codeclimate.com/github/milewdev/rol.png)](https://codeclimate.com/github/milewdev/rol)
[![Coverage Status](https://coveralls.io/repos/milewdev/rol/badge.png?branch=master)](https://coveralls.io/r/milewdev/rol?branch=master)
[![Dependencies](https://gemnasium.com/milewdev/rol.svg)](https://gemnasium.com/milewdev/rol)


#### What is rol?
rol defines Ruby objects from a hash of attributes and methods:

```ruby
require 'rol'

object = rol({
  width: 2,
  height: 3,
  area: -> { @width * @height },
  scale: -> (factor) {
    @width *= factor
    @height *= factor
  }
})

print object.width, ' ', object.height, ' ', object.area, "\n"  # => 2 3 6
object.width = 4
print object.width, ' ', object.height, ' ', object.area, "\n"  # => 4 3 12
object.scale(10)
print object.width, ' ', object.height, ' ', object.area, "\n"  # => 40 30 1200
```


#### Installation

```shell
$ gem install rol
```

To uninstall:

```shell
$ gem uninstall rol
```


#### Usage

rol provides a quick way to create objects on the fly without having to create
a full class.  For example, the following creates an object with an attribute x
that is initialized to the value 3:

```ruby
require 'rol'
coord = rol({ x: 3 })
puts coord.x  # => 3
```

Attributes can be assigned to:

```ruby
require 'rol'
coord = rol({ x: 3 })
puts coord.x  # => 3
coord.x = 7
puts coord.x  # => 7
```

Methods can also be defined:

```ruby
require 'date'
require 'rol'
today = rol({ formatted: -> { Date.new(2014,11,24).strftime('%Y.%m.%d') } })
puts today.formatted  # => 2014.11.24
```

Methods can take arguments:

```ruby
require 'rol'
friendly = rol({ greet: -> (name) { "Hi #{name}!" } })
puts friendly.greet('Spot')   # => Hi Spot!
```

Attributes are defined as instance variables and are therefore accessible
from methods:

```ruby
require 'rol'
counter = rol({
  current: 0,
  increment: -> { @current += 1 }
})
puts counter.current  # => 0
counter.increment
puts counter.current  # => 1
```


#### Equivalents

Using rol to define an attribute:

```ruby
object = rol({ x: 123 })
puts object.x  # => 123
```

is equivalent to:

```ruby
object = Object.new

def object.x
  @x
end

def object.x=(value)
  @x = value
end

object.x = 123

puts object.x  # => 123
```

Using rol to define a method:

```ruby
object = rol({
  my_method: -> (arg) { puts arg }
})

object.my_method(123)  # => 123
```

is equivalent to:

```ruby
object = Object.new

def object.my_method(arg)
  puts arg
end

object.my_method(123)  # => 123
```


#### Development Documentation
[Here](notes/development.md).


#### Thanks
- [Apple](http://www.apple.com)
- [GitHub](https://github.com), [GitHub pages](http://pages.github.com)
- [Ruby](http://www.ruby-lang.org), [RubyGems](https://rubygems.org), [rake](http://rake.rubyforge.org)
- [Atom](https://atom.io)
- [Travis CI](https://travis-ci.org), [Code Climate](https://codeclimate.com), [Coveralls](https://coveralls.io), [Gemnasium](https://gemnasium.com/)
- [Vagrant](https://www.vagrantup.com)
- [VMware](http://www.vmware.com)
