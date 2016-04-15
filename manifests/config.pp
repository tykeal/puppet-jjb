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
class jjb::config (
  Hash $config,
  String $ini_dir,
  String $ini_file,
  String $ini_owner,
  String $ini_group,
  Boolean $manage_ini_dir,
) {
  include jjb::params

  validate_absolute_path($ini_dir)
  validate_absolute_path($ini_file)

  $_config = merge($jjb::params::default_config, $config)

  if ($manage_ini_dir) {
    file { $ini_dir:
      ensure => directory,
      owner  => $ini_owner,
      group  => $ini_group,
    }
  }

  ini_config {$ini_file:
    config => $_config,
    owner  => $ini_owner,
    group  => $ini_group,
  }
}
