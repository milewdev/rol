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
$ mkdir -p ~/work/rol
$ cd ~/work/rol
$ curl -L https://raw.github.com/milewdev/rol/master/Vagrantfile -o Vagrantfile
$ vagrant up --provider=vmware_fusion
...
```

#####Check installation:
In a terminal window on the vm (guest machine):
```
$ cd ~/Documents/rol
$ ./_test
/Users/vagrant/.rbenv/versions/2.1.2/lib/ruby/gems/2.1.0/gems/rest-client-1.6.7/lib/restclient/exceptions.rb:157: warning: assigned but unused variable - message
/Users/vagrant/.rbenv/versions/2.1.2/lib/ruby/gems/2.1.0/gems/rest-client-1.6.7/lib/restclient/exceptions.rb:167: warning: assigned but unused variable - message
/Users/vagrant/.rbenv/versions/2.1.2/lib/ruby/gems/2.1.0/gems/rest-client-1.6.7/lib/restclient/response.rb:11: warning: method redefined; discarding old body
/Users/vagrant/.rbenv/versions/2.1.2/lib/ruby/gems/2.1.0/gems/rest-client-1.6.7/lib/restclient/payload.rb:47: warning: mismatched indentations at 'end' with 'case' at 40
/Users/vagrant/.rbenv/versions/2.1.2/lib/ruby/gems/2.1.0/gems/simplecov-html-0.8.0/lib/simplecov-html.rb:58: warning: possibly useless use of a variable in void context
[Coveralls] Set up the SimpleCov formatter.
[Coveralls] Using SimpleCov's default settings.
Run options: --seed 31355

# Running tests:

...........................................................

Finished tests in 0.016475s, 3581.1836 tests/s, 6373.2929 assertions/s.

59 tests, 105 assertions, 0 failures, 0 errors, 0 skips
[Coveralls] Outside the Travis environment, not sending data.
```

#####Uninstall:
**WARNING**: This will completely destroy the vm so you likely want to ensure that you have
pushed any and all code changes to GitHub beforehand.

In a terminal window on the host machine:
```
$ cd ~/work/rol
$ vagrant destroy -f
$ cd ~
$ rm -r ~/work/rol    # and possibly rm -r ~/work if it is now empty
```


#####Development Notes:
- Branch **master** contains the latest version of the application code.  Older releases have their own branches.

- The library entry point is Rol::run(), defined in lib/rol.rb.

- ./_test will run all business/unit tests.  Leave a terminal window open during development and
run ./_test as you make changes to code.

- ./_lint will run various checks against the source code, typically looking for things that cropped up in the TODO list, such as a change in naming convention; in this case, the checks will ensure that the old names are not used anywhere. Warning: the checks are not sophisticated and may report things that are in fact not erroneous.

- ./_build will create the gem file rol-x.y.z.gem

- ./_install will install the gem locally.

- ./_uninstall will uninstall the local gem (undo of _install).

- ./_all simply calls _test, _lint, _build, _uninstall, and _install, in that order.

- If you wish to modify the Vagrantfile, it is best to do so on the host machine (~/work/rol/Vagrantfile)
so that you can easily do an edit/vagrant up/vagrant destroy cycle.  Once you have finished making
changes, vagrant up and then in a terminal window on the vm do something like:
```
$ cd ~/Documents/rol
$ cp /vagrant/Vagrantfile .
$ git status
...
$ git add Vagrantfile
$ git commit -S -m "Insert description of change to Vagrantfile here."
...
$ git push
...
```
