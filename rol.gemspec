require "./lib/rol/version"

Gem::Specification.new do |s|
  s.name                        = "rol"
  s.version                     = Rol::Version
  s.homepage                    = "https://github.com/milewdev/rol"
  s.summary                     = "rol defines Ruby objects from a hash of attributes and methods"
  s.description                 = <<-EOS
                                  rol defines Ruby objects from a hash of attributes and methods
                                  EOS
  s.author                      = "Michael Lewandowski"
  s.email                       = "milewdev@gmail.com"
  s.license                     = "MIT"
  s.requirements                = [ "Ruby 2" ]
  s.platform                    = Gem::Platform::RUBY
  s.required_ruby_version       = "~> 2"
  s.files                       = Dir[ "lib/**/**", "LICENSE" ]
  s.require_paths               = [ "lib" ]
  s.add_development_dependency  "mocha", "~> 0"
  s.add_development_dependency  "bundler", "~> 1"
  s.add_development_dependency  "rake", "~> 10"
  s.test_files                  = Dir[ "test/**/*_test.rb" ]
end
