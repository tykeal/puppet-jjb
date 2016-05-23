# Class: jjb::config
# ===========================
#
# Configure JJB
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
# @param config Configuration hash
#
# @param ini_dir Fully qualified path to where the ini configuration should live
#
# @param ini_file Fully qualified name of the ini configuration file
#
# @param ini_group Group owner of the ini configuration file
#
# @param ini_mode File mode for the ini configuration file
#
# @param ini_owner Owner of the ini configuration file
#
# @param manage_ini_dir If the ini_dir should be managed or not
#
class jjb::config (
  Hash $config,
  Pattern['^\/'] $ini_dir,
  Pattern['^\/'] $ini_file,
  String[1] $ini_group,
  Pattern['^\d{4}$'] $ini_mode,
  String[1] $ini_owner,
  Boolean $manage_ini_dir,
) {
  include jjb::params

  $_config = merge($jjb::params::default_config, $config)

  if ($manage_ini_dir) {
    file { $ini_dir:
      ensure => directory,
      owner  => $ini_owner,
      group  => $ini_group,
    }
  }

  ini_config {$ini_file:
    config    => $_config,
    group     => $ini_group,
    mode      => $ini_mode,
    owner     => $ini_owner,
    show_diff => false,
  }
}
