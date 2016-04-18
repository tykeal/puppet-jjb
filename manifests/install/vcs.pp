# Class: jjb::install::vcs
# ===========================
#
# Clone Jenkins Job Builder into a specific location
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
# @param vcs_info The version control system installation block
#
class jjb::install::vcs (
  Struct[{vcs_path   => Pattern['^\/'],
          vcs_ref    => String,
          vcs_source => String[1],
          vcs_type   => Enum['git', 'bzr', 'cvs', 'hg', 'p4', 'svn'],}]
          $vcs_info,
) {
  vcsrepo { $vcs_info['vcs_path']:
    ensure   => present,
    provider => $vcs_info['vcs_type'],
    source   => $vcs_info['vcs_source'],
    revision => $vcs_info['vcs_ref'],
  }
}
