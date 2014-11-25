### Committing to git
- Use a signed commit.
- Does the commit need to be built by the CI server?  Use [ci skip] if not.

### Publishing a New Version
- Is HISTORY.md up to date?
- Is lib/rol/version.rb correct?
- Is README.md up to date?
- Check git status; is everything committed and pushed?
- If necessary, force a build on travis-ci.org; did the build pass?
- git tag -s X.Y.Z -m 'description of release'
- git branch X.Y.Z
- git push origin X.Y.Z
- gem push rol-X.Y.Z.gem
- Is rubygems.org showing the pushed version?
- Are the badges up to date on the README in github?
- Install the gem in a clean environment and run a quick test against a small input file.
