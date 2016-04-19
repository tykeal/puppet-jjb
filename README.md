# jjb

[![Build Status](https://travis-ci.org/tykeal/puppet-jjb.png)](https://travis-ci.org/tykeal/puppet-jjb)

#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with jjb](#setup)
    * [What jjb affects](#what-jjb-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with jjb](#beginning-with-jjb)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

Installs and configures Jenkins Job Builder (JJB).

Does *not* create JJB layouts. In all honesty that is better served out of
separate repo that is either dedicated to it or to other CI related components
and having jobs built into your CI to do validation and instantiation into your
CI.

## Setup

### What jjb affects

* Install jenkins-job-builder via pip or from a system package
* Optionally install via source repository
* Optionally install into a virtualenv

### Setup Requirements

If installing into a virtualenv then please make sure that you instantiate
[stankevich/python](https://forge.puppet.com/stankevich/python) in a way that
installs the needed system components.

*NOTE* The default of `stankevich/python` is to ensure that the python
development tools are absent but they are a requirement for python-virtualenv on
RedHat family distributions.

### Beginning with jjb

Installing a basic setup (this will not properly connect to a jenkins but it
will install cleanly)

```puppet
class { 'jjb':
}
```

A more appropriate configuration would be something along the lines of

```puppet
class { 'jjb':
  config       => {
    jenkins    => {
      user     => 'jobbuilder',
      password => 'Super_$ecRet_p@$$w0rd!',
      url      => 'https://jenkins.example.com'
    },
  },
}
```

## Usage

This module is really mostly designed to get JJB installed and configured so
that it can talk with a Jenkins instance. Managing JJB layouts is best left for
jobs living inside Jenkins itself. For an example of how to hook configure your
Jenkins system to validate and manage updating your Jenkins against a Gerrit
system I would recommend looking at the following configurations:

[OpenDaylight
releng/builder](https://git.opendaylight.org/gerrit/gitweb?p=releng/builder.git;a=blob;f=jjb/releng-jobs.yaml;h=2adbc8d251e7cf13b65cd66a553f91f09ebd2d1f;hb=HEAD)
[FD.io
ci-management](https://gerrit.fd.io/r/gitweb?p=ci-management.git;a=blob;f=jjb/ci-management/ci-management-jobs.yaml;h=06bcb75ad8c11769d46b031b7bfced019566d99c;hb=HEAD)
[Zephyr Projection
ci-management](https://gerrit.zephyrproject.org/r/gitweb?p=ci-management.git;a=blob;f=jjb/ci-management-jobs.yaml;h=cd73102915ee4ae9869481ac9c0ab063253ea383;hb=HEAD)

## Reference

*Class:* `jjb`

`config`
A configuration hash that defines how the jenkins_jobs.ini is created. Each
section of the ini file is defined by it's own named subhash. At present JJB
understands the following sections:

*jenkins* This is a mandatory section for JJB and if it is not defined will
default to example values

*hipchat* This is an option section for JJB and if not set will not be added to
the configuration file

This hash is utilized by
[tykeal/ini_config](https://forge.puppet.com/tykeal/ini_config) to create the
configuration. Outside of merging defaults in for the jenkins section it is
passed unmodified. See the documentation of `tykeal/ini_config` for more
details.

`install_type`
Valid options are 'package', 'system', or 'venv' with a default of 'system'.

This option determins how JJB will be installed.

'system' will use pip to install into the base system itself

'venv' will install into a virtualenv that is created specifically for the
install

'package' will attempt to install using the system package management. As JJB is
not in all upstream repos you will need to make sure that the repo that you're
installing from is already configured on the system should you choose to utilize
this option.

`install_via_source`
If true then a checkout of JJB will be made and utilized
for installation into either the system or a venv. If `install_type` is
'package' than this option is ignored. Defaults to false.

`ini_dir`
The directory where the inifile should be created. Defaults to
'/etc/jenkins_jobs'

`ini_file`
The configuration file that should be managed. Defaults to
'/etc/jenkins_jobs/jenkins_jobs.ini'

`ini_group`
The owning group for the inifile. Defaults to 'root'

`ini_mode`
The file mode for the inifile. Defaults to '0440'

`ini_owner`
The owning user for the inifile. Defaults to 'root'

`manage_ini_dir`
If true then `ini_dir` will be created. Defaults to true

`package_name`
The name of the package to install. Defaults to 'jenkins-job-builder'

`package_version`
The version of the package to install. Defaults to 'present'. Other options are
'absent', 'latest' or a specific version.

`vcs_info`
A configuration hash for use if installing via source. The options are used to
drive the configuration of a vcsrepo resource. The default hash is configured as
follows. This hash is useful only if `install_via_source` is true

```puppet
vcs_info = {
  vcs_path   => '/opt/vcs_jenkins_job_builder',
  vcs_ref    => 'master',
  vcs_source => 'https://git.openstack.org/openstack-infra/jenkins-job-builder.git',
  vcs_type   => 'git',
}
```

`venv_path`
The path for the virtualenv if `install_type` is 'venv'. Defaults to
'/opt/venv_jenkins_job_builder'

## Limitations

This module has only been tested on RedHat / CentOS 7. It should work properly
on any system that also supports `stankevich/python`.

## Development

Fork it on GitHub and send a PR
