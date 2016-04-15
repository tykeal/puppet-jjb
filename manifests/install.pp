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
# @param system_install Should JJB be installed systemwide or into a virtualenv.
#   True (default) == install systemwide
#   False == install into a virtualenv
#
class jjb::install (
  Boolean $system_install
) {
}
