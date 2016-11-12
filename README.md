# Morula

> efficient testing for monorepos

Monorepos are Git repositories that contain multiple code bases.
Morula runs the tests for all subprojects in a monorepo.
Optionally only for the code bases that contain changes.
This makes testing monorepos easy, reliable, and fast.


## Repo structure

Morula expects the repository to contain subprojects in top-level folders,
plus a Morula configuration file.
The subprojects must contain a standardized set of scripts
defined by the
[o-tools](https://github.com/Originate/o-tools-node) convention:
- `bin/setup`: makes the subproject runnable, for example by installing dependencies
- `bin/spec`: runs all tests for this subproject


## Configuration file (coming soon)

The config file - named morula.yml - is located in the root of the monorepo.
It defines which subprojects should be tested first/last,
and which ones should always/never be tested independent of changes.

__morula.yml__
```yml
main-branch-name: master

before-all:
  - shared

after-all:
  - e2e

always:
  - e2e

never:
  - website
```


## Commands

- `morula setup`:
  runs the `bin/setup` scripts for each subproject

- `morula test`:
  determines which folders contain changes
  and runs the tests for only the respective subprojects


## Why Monorepos?

Large monolithic code bases should be broken up
into more manageable and reusable pieces.
Some of these pieces will be completely independent
from the product they originated from
and become a completely separate project.
Those are the straightforward cases.
Problematic are the pieces that are more like _subprojects_ of the main project
and should remain in the vicinity of it.
These projects are best organized as one big monorepo and not as completely separate projects,
for a number of reasons:

- There is currently not enough tool support
  to work with subprojects that live in their own repositories.
  Cloning, setting up, and keeping dozens of repos up to date
  with ongoing development is a lot of boilerplate activity.
- GitHub doesn't support pull requests across several repos,
  necessitating one pull request per repository to implement many changes.
  This means changes
  that break integration with other subprojects
  cannot be found early in the development process.
- End-to-end testing needs to happen on each change in any subproject
  and combine several repositories,
  which is difficult to implement on CI servers.
- If documentation is extracted into its own subproject,
  it is hard to keep it in sync with ongoing development,
  since documentation updates cannot be part of the pull requests
  for the code changes.

More motivation can be found in the
[monorepo design document of BabelJS](https://github.com/babel/babel/blob/master/doc/design/monorepo.md).

Because of all these reasons,
many complex open-source projects
like [React](https://github.com/facebook/react), [Meteor](https://github.com/meteor/meteor), Ember, and [Babel](https://github.com/babel/babel)
have moved toward a code structure that has
all subprojects into the same repository, i.e. a _monorepository_.
Doing so allows to implement, review, and test changes
in several subprojects together and thereby address all challenges mentioned above.

Examples of popular monorepos are:

* [Docker](https://github.com/docker/docker)
* [Node](https://github.com/nodejs/node)
* [Kubernetes](https://github.com/kubernetes/kubernetes)
* [AngularJS](https://github.com/angular/angular.js)
* [Linux](https://github.com/torvalds/linux)
* [Bootstrap](https://github.com/twbs/bootstrap)
* [React](https://github.com/facebook/react)

## Related Work

__[Lerna](https://github.com/lerna/lerna)__
- only works if all subprojects are NPM packages
- enforces an unnecessarily nested directory structure

