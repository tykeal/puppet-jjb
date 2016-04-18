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
  $install_type       = 'venv'
  $install_via_source = false

  $ini_dir   = '/etc/jenkins_jobs'
  $ini_file  = '/etc/jenkins_jobs/jenkins_jobs.ini'
  $ini_owner = 'root'
  $ini_group = 'root'

  $manage_ini_dir  = true
  $package_name    = 'jenkins-job-builder'
  $package_version = 'present'

  $vcs_info = {
    vcs_path   => '/opt/vcs_jenkins_job_builder',
    vcs_ref    => 'master',
    # lint:ignore:80chars
    vcs_source => 'https://git.openstack.org/openstack-infra/jenkins-job-builder.git',
    # lint:endignore
    vcs_type   => 'git',
  }

  $venv_path = '/opt/venv_jenkins_job_builder'

  $default_config = {
    'jenkins'    => {
      'user'     => 'jobbuilder',
      'password' => 'YOU_NEED_TO_SET_ME!',
      'url'      => 'https://localhost:8080',
    },
  }
}
