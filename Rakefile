require "rake/testtask"
require "pathname"
require_relative "lib/rol/version"


task :default => :test


Rake::TestTask.new :test do |t|
  t.test_files = FileList["test/**/*_test.rb"]
  t.warning = true
end


desc "Build gem"
task :build do
  system "gem build rol.gemspec"
end


desc "Install gem locally"
task :install => :build do
  system "gem install rol-#{Rol::Version}.gem"
end


desc "Uninstall gem locally"
task :uninstall do
  system "gem uninstall -x rol"
end
