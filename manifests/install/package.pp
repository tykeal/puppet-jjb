# Class: jjb::install::package
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
# @param package_name Name of the package to install
#
# @param package_version Version of package that should be installed (defaults
#   to 'present')
#
class jjb::install::package (
  String[1] $package_name,
  String[1] $package_version,
) {
  ensure_packages($package_name, { ensure => $package_version })
}
