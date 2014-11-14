### Copying this Template
This is a template Ruby gem project.  To use it:

- Copy this template project to a new one on github and then launch it in a vm.  For example:
  ```
  # Create a new_project repo in your github account, then do:

  $ git clone https://github.com/milewdev/devenv-rubygem.git /Users/you/work/new_project
  $ cd /Users/you/work/new_project

  # Edit the Vagrantfile and change the PROJECT_NAME constant value at the top of
  # the file to your new_project name, then do:

  $ rm -rf .git
  $ git init
  $ git add .
  $ git commit -S -m "Initial commit"
  $ git remote add origin https://github.com/your_github_account/new_project.git
  $ git push origin master

  # This deletes everything except the Vagrantfile:
  $ find * -maxdepth 0 -name 'Vagrantfile' -prune -o -exec rm -rf '{}' ';'

  $ vagrant up --provider=vmware_fusion
  ```
- Register your new repo with Travis CI, Coveralls, Code Climate, and Gemnasium.
- Replace all occurrences of roughgem and devenv-rubygem with your project name.  This includes file and directory names (e.g. lib/roughgem/roughgem.rb).
- Modify this README file to suit your project: remove these notes, fill in the description for 'What is ...?', fix the documentation links, etc.
- Run ./_test, ./_lint, ./_build and ./_install, and address any issues.
- Push your changes to github.
- Verify that [Travis CI](https://travis-ci.org), [Code Climate](https://codeclimate.com), [Coveralls](https://coveralls.io), and [Gemnasium](https://gemnasium.com/) work.

<br>
<br>
<br>



[![Gem Version](https://badge.fury.io/rb/roughgem.svg)](http://badge.fury.io/rb/roughgem)
[![Build Status](https://travis-ci.org/milewdev/devenv-rubygem.svg?branch=master)](https://travis-ci.org/milewdev/devenv-rubygem)
[![Code Climate](https://codeclimate.com/github/milewdev/devenv-rubygem.png)](https://codeclimate.com/github/milewdev/devenv-rubygem)
[![Coverage Status](https://coveralls.io/repos/milewdev/devenv-rubygem/badge.png?branch=master)](https://coveralls.io/r/milewdev/devenv-rubygem?branch=master)
[![Dependencies](https://gemnasium.com/milewdev/devenv-rubygem.svg)](https://gemnasium.com/milewdev/devenv-rubygem)


### What is roughgem?
TODO: FILL IN DESCRIPTION HERE


### Documentation
[Here](http://milewdev.github.io/roughgem.doc/) (documentation source is [here](https://github.com/milewdev/roughgem.doc)).


### Development Setup

#####Requirements:
- [OS X](https://www.apple.com/osx/)
- [VMware Fusion](http://www.vmware.com/ca/en/products/fusion)
- [Vagrant](http://www.vagrantup.com)
- [Vagrant VMware provider](https://www.vagrantup.com/vmware)
- An OS X Vagrant box named OSX109 (you can use a different name by changing the BOX variable near the top of the Vagrantfile downloaded in the Install step below)

#####Install:
In a terminal window on the host machine:
```
$ mkdir -p ~/work/roughgem
$ cd ~/work/roughgem
$ curl -L https://raw.github.com/milewdev/roughgem/master/Vagrantfile -o Vagrantfile
$ vagrant up --provider=vmware_fusion
...
```

#####Check installation:
In a terminal window on the vm (guest machine):
```
$ cd ~/Documents/roughgem
$ ./_test
--------------------------------------------------------------------------------
/usr/local/Cellar/ruby/2.1.2_2/lib/ruby/2.1.0/rubygems/defaults/operating_system.rb:2: warning: method redefined; discarding old default_dir
/usr/local/Cellar/ruby/2.1.2_2/lib/ruby/2.1.0/rubygems/defaults.rb:29: warning: previous definition of default_dir was here
/usr/local/Cellar/ruby/2.1.2_2/lib/ruby/2.1.0/rubygems/defaults/operating_system.rb:39: warning: method redefined; discarding old default_path
/usr/local/Cellar/ruby/2.1.2_2/lib/ruby/2.1.0/rubygems/defaults.rb:91: warning: previous definition of default_path was here
/usr/local/Cellar/ruby/2.1.2_2/lib/ruby/2.1.0/rubygems/defaults/operating_system.rb:47: warning: method redefined; discarding old default_bindir
/usr/local/Cellar/ruby/2.1.2_2/lib/ruby/2.1.0/rubygems/defaults.rb:116: warning: previous definition of default_bindir was here
/usr/local/lib/ruby/gems/2.1.0/gems/rest-client-1.6.7/lib/restclient/exceptions.rb:157: warning: assigned but unused variable - message
/usr/local/lib/ruby/gems/2.1.0/gems/rest-client-1.6.7/lib/restclient/exceptions.rb:167: warning: assigned but unused variable - message
/usr/local/lib/ruby/gems/2.1.0/gems/rest-client-1.6.7/lib/restclient/response.rb:11: warning: method redefined; discarding old body
/usr/local/lib/ruby/gems/2.1.0/gems/rest-client-1.6.7/lib/restclient/payload.rb:47: warning: mismatched indentations at 'end' with 'case' at 40
/usr/local/lib/ruby/gems/2.1.0/gems/simplecov-html-0.8.0/lib/simplecov-html.rb:58: warning: possibly useless use of a variable in void context
[Coveralls] Set up the SimpleCov formatter.
[Coveralls] Using SimpleCov's default settings.
Run options: --seed 36710

# Running tests:

.

Finished tests in 0.001385s, 722.0217 tests/s, 722.0217 assertions/s.

1 tests, 1 assertions, 0 failures, 0 errors, 0 skips
[Coveralls] Outside the Travis environment, not sending data.
```

#####Uninstall:
**WARNING**: This will completely destroy the vm so you likely want to ensure that you have
pushed any and all code changes to GitHub beforehand.

In a terminal window on the host machine:
```
$ cd ~/work/roughgem
$ vagrant destroy -f
$ cd ~
$ rm -r ~/work/roughgem    # and possibly rm -r ~/work if it is now empty
```


#####Development Notes:
- branch **master** contains the latest version of the application code.  Older releases have their own branches.

- `bin/roughgem` launches the application; it simply calls the program's main entry point, RoughGem::run (`lib/roughgem/roughgem.rb`).

- ./_test will run all business/unit tests.  Leave a terminal window open during development and
run ./_test as you make changes to code.

- ./_lint will run various checks against the source code, typically looking for things that cropped up in the TODO list, such as a change in naming convention; in this case, the checks will ensure that the old names are not used anywhere. Warning: the checks are not sophisticated and may report things that are in fact not erroneous.

- ./_build will create the gem file roughgem-x.y.z.gem

- ./_install will install the gem locally.

- If you wish to modify the Vagrantfile, it is best to do so on the host machine (~/work/roughgem/Vagrantfile)
so that you can easily do an edit/vagrant up/vagrant destroy cycle.  Once you have finished making
changes, vagrant up and then in a terminal window on the vm do something like:
    ```
    $ cd ~/Documents/roughgem
    $ cp /vagrant/Vagrantfile .
    $ git status
    ...
    $ git add Vagrantfile
    $ git commit -S -m "Insert description of change to Vagrantfile here."
    ...
    $ git push
    ...
    ```


### Thanks
- [Apple](http://www.apple.com)
- [GitHub](https://github.com), [GitHub pages](http://pages.github.com)
- [Ruby](http://www.ruby-lang.org), [RubyGems](https://rubygems.org), [rake](http://rake.rubyforge.org)
- [TextMate](http://macromates.com)
- [Travis CI](https://travis-ci.org), [Code Climate](https://codeclimate.com), [Coveralls](https://coveralls.io), [Gemnasium](https://gemnasium.com/)
- [Vagrant](https://www.vagrantup.com)
- [VMware](http://www.vmware.com)
