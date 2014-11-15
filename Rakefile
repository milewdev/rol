require "rake/testtask"
require "pathname"
require_relative "lib/rol/version"


task :default => [ :test ]
task :install => [ :build ]


desc "Run test, build, and install tasks"
task :all => [ :test, :build, :install ]


Rake::TestTask.new :test do |t|
  t.test_files = FileList["test/**/*_test.rb"]
  t.warning = true
end


desc "Build gem"
task :build do
  system "gem build rol.gemspec"
end


desc "Install gem locally (does an uninstall first)"
task :install => :uninstall do
  system "gem install rol-#{Rol::Version}.gem"
end


desc "Uninstall gem locally"
task :uninstall do
  system "gem uninstall -x rol"
end
