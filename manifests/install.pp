# Class: jjb::install
# ===========================
#
# Install JJB
#
# Authors
# -------
#
# Andrew Grimberg <agrimberg@linuxfoundation.org>
#
# Copyright
# ---------
#
# Copyright 2016 Andrew Grimberg
#
# License
# -------
#
# Apache-2.0 <http://spdx.org/licenses/Apache-2.0>
#
# @param install_type Determines what type of install to do.
#   package == install using a system package;
#   system  == install via pip as a systemwide installation;
#   venv    == install into a virtual env (default)
#
# @param install_via_source If install_type is system or venv, determine if
#   installation should be done from a source repository
#
# @param package_name If install_type is package then install this package with
#   at revision package_version (aka ensure)
#
# @param package_version If install_type is package or install_via_source is
#   false what version of package should be installed (defaults to 'present')
#
# @param vcs_info If install_via_source then define resources for installation
#   via a version control repo
#
# @param venv_path If install_type is venv then what is the path to the venv
#
class jjb::install (
  Enum['package', 'system', 'venv'] $install_type,
  Boolean $install_via_source,
  String[1] $package_name,
  String[1] $package_version,
  Struct[{vcs_path   => Pattern['^\/'],
          vcs_ref    => String,
          vcs_source => String[1],
          vcs_type   => Enum['git', 'bzr', 'cvs', 'hg', 'p4', 'svn'],}]
          $vcs_info,
  Pattern['^\/'] $venv_path,
) {
  if ($install_type != 'package' and $install_via_source) {
    class { 'jjb::install::vcs':
      vcs_info => $vcs_info,
    }
  }

  case $install_type {
    'package': {
      class { 'jjb::install::package':
        package_name    => $package_name,
        package_version => $package_version,
      }
    }
    'system': {
      class { 'jjb::install::system':
        install_via_source => $install_via_source,
        package_version    => $package_version,
        vcs_path           => $vcs_info['vcs_path'],
      }
      if ($install_via_source) {
        Class['jjb::install::vcs'] ->
        Class['jjb::install::system']
      }
    }
    'venv': {
      class { 'jjb::install::venv':
        install_via_source => $install_via_source,
        package_version    => $package_version,
        vcs_path           => $vcs_info['vcs_path'],
        venv_path          => $venv_path,
      }
      if ($install_via_source) {
        Class['jjb::install::vcs'] ->
        Class['jjb::install::venv']
      }
    }
    default: { fail("Invalid \$install_type of ${install_type}") }
  }
}
