# Class: jjb::install::venv
# ===========================
#
# Install JJB into a virtual environment
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
# @param install_via_source If install_type is system or venv, determine if
#   installation should be done from a source repository
#
# @param package_version If install_type is package or install_via_source is
#   false what version of package should be installed (defaults to 'present')
#
# @param vcs_path If install-via_source then we need the path to the source vcs
#
# @param venv_path If install_type is venv then what is the path to the venv
#
class jjb::install::venv (
  Boolean $install_via_source,
  String[1] $package_version,
  Pattern['^\/'] $vcs_path,
  Pattern['^\/'] $venv_path,
) {
}
