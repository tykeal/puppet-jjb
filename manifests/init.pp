# Class: jjb
# ===========================
#
# Install and manage Jenkins Job Builder (JJB)
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
# @param system_install Should JJB be installed systemwide or into a virtualenv.
#   True (default) == install systemwide
#   False == install into a virtualenv
#
# @example
#   include jjb
#
class jjb (
  Hash $config                 = {},
  Enum['package', 'system', 'venv'] $install_type = $jjb::params::install_type,
  Boolean $install_via_source  = $jjb::params::install_via_source,
  Pattern['^\/'] $ini_dir      = $jjb::params::ini_dir,
  Pattern['^\/'] $ini_file     = $jjb::params::ini_file,
  String[1] $ini_group         = $jjb::params::ini_group,
  Pattern['^\d{4}$'] $ini_mode = $jjb::params::ini_mode,
  String[1] $ini_owner         = $jjb::params::ini_owner,
  Boolean $manage_ini_dir      = $jjb::params::manage_ini_dir,
  String[1] $package_name      = $jjb::params::package_name,
  String[1] $package_version   = $jjb::params::package_version,
  Struct[{vcs_path   => Pattern['^\/'],
          vcs_ref    => String,
          vcs_source => String[1],
          vcs_type   => Enum['git', 'bzr', 'cvs', 'hg', 'p4', 'svn'],}]
          $vcs_info            = $jjb::params::vcs_info,
  Pattern['^\/'] $venv_path    = $jjb::params::venv_path,
) inherits jjb::params {
  anchor { 'jjb::begin': }
  anchor { 'jjb::end': }

  class { 'jjb::install':
    install_type       => $install_type,
    install_via_source => $install_via_source,
    package_name       => $package_name,
    package_version    => $package_version,
    vcs_info           => $vcs_info,
    venv_path          => $venv_path,
  }

  class { 'jjb::config':
    config         => $config,
    ini_dir        => $ini_dir,
    ini_file       => $ini_file,
    ini_group      => $ini_group,
    ini_mode       => $ini_mode,
    ini_owner      => $ini_owner,
    manage_ini_dir => $manage_ini_dir,
  }

  Anchor['jjb::begin'] ->
    Class['jjb::install'] ->
    Class['jjb::config'] ->
  Anchor['jjb::end']
}
