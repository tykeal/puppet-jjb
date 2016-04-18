# Class: jjb::install::system
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
# @param install_via_source If install_type is system or venv, determine if
#   installation should be done from a source repository
#
# @param package_version If install_type is package or install_via_source is
#   false what version of package should be installed (defaults to 'present')
#
# @param vcs_pach If install_via_source then this is the path to install from
#
class jjb::install::system (
  Boolean $install_via_source,
  String[1] $package_version,
  Pattern['^\/'] $vcs_path,
) {
}
