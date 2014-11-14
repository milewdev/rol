### Committing to git
- Use a signed commit.
- Does the commit need to be built by the CI server?  Use [ci skip] if not.

### Publishing a New Version
- Is HISTORY.md up to date?
- Is lib/roughgem/version.rb correct?
- Is the documentation web site up to date?
- Is the version number correct on the documentation web site (<title> and in the header)?
- Is the copyright date correct on the documentation web site (in the footer)?
- Check git status; is everything committed and pushed?
- If necessary, force a build on travis-ci.org; did the build pass?
- git tag -s X.Y.Z -m 'description of release'
- gem push roughgem-X.Y.Z.gem
- also tag and push the documentation web site
- Is rubygems.org showing the pushed version?
- Are the badges up to date on the README in github?
- Install the gem in a clean environment and run a quick test against a small input file.
