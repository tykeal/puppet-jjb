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
  Hash $config            = {},
  String $ini_dir         = $jjb::params::ini_dir,
  String $ini_file        = $jjb::params::ini_file,
  String $ini_owner       = $jjb::params::ini_owner,
  String $ini_group       = $jjb::params::ini_group,
  Boolean $manage_ini_dir = $jjb::params::manage_ini_dir,
  Boolean $system_install = $jjb::params::system_install
) inherits jjb::params {
  anchor { 'jjb::begin': }
  anchor { 'jjb::end': }

  class { 'jjb::install':
    system_install => $system_install,
  }

  class { 'jjb::config':
    config         => $config,
    ini_dir        => $ini_dir,
    ini_file       => $ini_file,
    ini_owner      => $ini_owner,
    ini_group      => $ini_group,
    manage_ini_dir => $manage_ini_dir,
  }

  Anchor['jjb::begin'] ->
    Class['jjb::install'] ->
    Class['jjb::config'] ->
  Anchor['jjb::end']
}
