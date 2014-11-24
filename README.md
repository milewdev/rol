[![Gem Version](https://badge.fury.io/rb/rol.svg)](http://badge.fury.io/rb/rol)
[![Build Status](https://travis-ci.org/milewdev/rol.svg?branch=master)](https://travis-ci.org/milewdev/rol)
[![Code Climate](https://codeclimate.com/github/milewdev/rol.png)](https://codeclimate.com/github/milewdev/rol)
[![Coverage Status](https://coveralls.io/repos/milewdev/rol/badge.png?branch=master)](https://coveralls.io/r/milewdev/rol?branch=master)
[![Dependencies](https://gemnasium.com/milewdev/rol.svg)](https://gemnasium.com/milewdev/rol)


## rol


### What is rol?
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

puts object.width, object.height, object.area   # => 2 3 6
object.scale(10)
puts object.width, object.height, object.area   # => 20 30 600
```


### Install

```shell
gem install rol
```


### Uninstall

```shell
gem uninstall rol
```


### Development Documentation
[Here](notes/development.md)


### Thanks
- [Apple](http://www.apple.com)
- [GitHub](https://github.com), [GitHub pages](http://pages.github.com)
- [Ruby](http://www.ruby-lang.org), [RubyGems](https://rubygems.org), [rake](http://rake.rubyforge.org)
- [Atom](https://atom.io)
- [Travis CI](https://travis-ci.org), [Code Climate](https://codeclimate.com), [Coveralls](https://coveralls.io), [Gemnasium](https://gemnasium.com/)
- [Vagrant](https://www.vagrantup.com)
- [VMware](http://www.vmware.com)
