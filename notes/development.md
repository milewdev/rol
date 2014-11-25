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
[Coveralls] Set up the SimpleCov formatter.
[Coveralls] Using SimpleCov's default settings.
Run options: --seed 29819

# Running tests:

...........................................................

Finished tests in 0.017485s, 3374.3208 tests/s, 6005.1473 assertions/s.

59 tests, 105 assertions, 0 failures, 0 errors, 0 skips
[Coveralls] Outside the Travis environment, not sending data.
```

#####Uninstall:
**WARNING**: This will destroy the vm so you likely want to ensure that you have
pushed any and all code changes to GitHub beforehand.

In a terminal window on the host machine:
```
$ cd ~/work/rol
$ vagrant destroy -f
$ cd ~
$ rm -r ~/work/rol    # and possibly rm -r ~/work if it is now empty
```


#####Development Notes:
- The library entry point is Kernel.rol(), defined in lib/rol/kernel.rb; however, that simply calls Rol.rol() which is defined in lib/rol.rb.

- Branch **master** contains the latest code, which may not have been released yet.  Each published release has its own branch.

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
