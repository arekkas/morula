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


## Commands

- __[`morula all <command>`](features/all.feature)__
  runs the given command in every subproject
- __[`morula changed <command>`](features/changed.feature)__
  runs the given command in every subproject
  that is changed compared to the main branch
- __[`morula setup`](features/setup.feature)__
  creates an example configuration file with the default options


## Repo structure

Your monorepository should contain the subprojects in top-level folders.

### How to make a task do different things in each subproject

Let's say your monorepo contains 2 projects,
and you want to use Morula to set all of them up with one command
by running `morula all setup`.
However, the different subprojects in your monorepo
require different commands to set them up.
For example, one project could be Node.JS code base
and you need to run `npm install` to set it up,
the other could be written in Ruby
and you need to run `bundle install` to set it up.

A good way to manage this situation is to create helper scripts in each subproject,
which contain the commands to set up their respective subproject.
In this case, you create a helper script called `setup` in each subproject.
These can be executable Bash scripts for Mac/Linux and CMD files for Windows.
Your directory structure looks something like this:

```
my_monorepo/
  │
  ├─ project_A/
  │  │
  │  ├─ setup      (contains commands to set up project A on Linux)
  │  ├─ setup.cmd  (contains commands to set up project A on Windows)
  │  └─ (code for project A)
  │
  └─ project_B/
     │
     ├─ setup      (contains commands to set up project B on Linux
     ├─ setup.cmd  (contains commands to set up project B on Windows)
     └─ (code for project B)
```

Another advantage of this setup is that when working within one subproject,
you can simply run `setup` to set it up,
and don't have to remember the project-specific commands any longer.


## Configuration

You can fine-tune the behavior of Morula
via command-line parameters
or a configuration file named `morula.*` in
[YAML](http://yaml.org),
[JSON](http://www.json.org),
[TOML](https://github.com/toml-lang/toml),
[HCL](https://github.com/hashicorp/hcl), or
[Java properties](https://docs.oracle.com/cd/E23095_01/Platform.93/ATGProgGuide/html/s0204propertiesfileformat01.html)
format.
The configuration options are:

<table>
  <tr>
    <th>name</th>
    <th>description</th>
    <th>default</th>
    <th>more info</th>
  </tr>
  <tr>
    <td><i>always</i></td>
    <td>always runs the given subproject, even if it has no changes</td>
    <td><code>""</code></td>
    <td><a href="features/always.feature">spec</a></td>
  </tr>
  <tr>
    <td><i>never</i></td>
    <td>never runs the given subproject, even if it has changes</td>
    <td><code>""</code></td>
    <td><a href="features/never.feature">spec</a></td>
  </tr>
  <tr>
    <td><i>after-all</i></td>
    <td>runs the given subproject after all others</td>
    <td><code>""</code></td>
    <td><a href="features/after-all.feature">spec</a></td>
  </tr>
  <tr>
    <td><i>before-all</i></td>
    <td>runs the given subproject before all others</td>
    <td><code>""</code></td>
    <td><a href="features/before-all.feature">spec</a></td>
  </tr>
  <tr>
    <td><i>color</i></td>
    <td>whether print output in color</td>
    <td><code>true</code></td>
    <td><a href="features/color.feature">spec</a></td>
  </tr>
</table>

Directories starting with a dot (e.g. `.git`)
are automatically ignored.
To create an example configuration file with the default options,
run `morula setup`.


## More info

- [why monorepos?](documentation/why_monorepos.md)


## Related projects

__[Lerna](https://github.com/lerna/lerna)__
- only works if all subprojects are NPM packages
- enforces an unnecessarily nested directory structure


## Contributing

Please see our [developer documentation](CONTRIBUTING.md)
