<img src="documentation/logo.png" width="600" height="111" alt="Morula logo">

[![Build Status](https://travis-ci.org/Originate/morula.svg?branch=master)](https://travis-ci.org/Originate/morula)
[![Build status](https://ci.appveyor.com/api/projects/status/v3ui3ce2uqpr5l2c/branch/master?svg=true)](https://ci.appveyor.com/project/kevgo/morula/branch/master)
[![Go Report Card](https://goreportcard.com/badge/github.com/Originate/morula)](https://goreportcard.com/report/github.com/Originate/morula)

Monorepos are Git repositories that contain multiple code bases,
typically for subprojects of the project in the repo.
Morula runs shell commands for all those subprojects within a monorepo.
Optionally only for the ones that contain changes.
This makes running administrative tasks,
for example tests or linters,
on code bases in monorepos easy, reliable, and fast.


## Installation

Download the appropriate binary for your platform from the
[release page](https://github.com/Originate/morula/releases/latest)
and save it somewhere in your PATH.


## Repo structure

Your monorepository should contain the subprojects in top-level folders.


## Commands

- __[`morula all <command>`](features/all.feature)__
  runs the given command in every subproject
- __[`morula changed <command>`](features/changed.feature)__
  runs the given command in every subproject
  that is changed compared to the main branch


## Configuration

You can fine-tune the behavior of Morula
via command-line parameters
or a configuration file `morula.*`
in YAML, JSON, TOML, HCL, or Java properties format.
The options are:


#### after-all

Runs the given subproject after all others.

- set via configuration file:

  __morula.yml__
  ```yml
  after-all: <SUBPROJECT NAME>
  ```

- set via command-line parameter:

  ```
  $ morula --after-all=<SUBPROJECT NAME> ...
  ```


#### before-all

Runs the given subproject before all others.

- set via configuration file:

  __morula.yml__
  ```yml
  before-all: <SUBPROJECT NAME>
  ```

- set via command-line parameter:

  ```
  $ morula --before-all=<SUBPROJECT NAME> ...
  ```


## More info

- [why monorepos](documentation/why_monorepos.md)
- feature specs for [`morula all`](features/all.feature) and [`morula changed`](features/changed.feature)


## Related projects

__[Lerna](https://github.com/lerna/lerna)__
- only works if all subprojects are NPM packages
- enforces an unnecessarily nested directory structure
