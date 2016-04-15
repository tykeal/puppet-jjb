# Class: jjb::params
# ===========================
#
# Defaults used by the jjb module
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
class jjb::params {
  $ini_dir        = '/etc/jenkins_jobs'
  $ini_file       = '/etc/jenkins_jobs/jenkins_jobs.ini'
  $ini_owner      = 'root'
  $ini_group      = 'root'
  $manage_ini_dir = true

  $system_install = true

  $default_config = {
    'jenkins'    => {
      'user'     => 'jobbuilder',
      'password' => 'YOU_NEED_TO_SET_ME!',
      'url'      => 'https://localhost:8080',
    },
  }
}
