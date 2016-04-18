# Class: jjb::install::pip
# ===========================
#
# Install JJB via pip
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
# @param install_type Install globally or into a virtualenv
#
# @param install_via_source Install from source
#
# @param package_name The name of the package to install
#
# @param package_version The version of the package to install
#
# @param vcs_path If install_via_source then this is the path to install from
#
# @param venv_path If install_type is venv then this is th path to install to
#
class jjb::install::pip (
  Enum['system', 'venv'] $install_type,
  Boolean $install_via_source,
  String[1] $package_name,
  String[1] $package_version,
  Pattern['^\/'] $vcs_path,
  Pattern['^\/'] $venv_path,
) {
  # only set $_url if we're installing from source otherwise don't set it so we
  # end up with the default undef
  if ($install_via_source) {
    $_url = $vcs_path
    $_subscribe = Vcsrepo[$vcs_path]
  }

  # only set $_venv if we're installing in a venv, otherwise don't set it so we
  # end up with the default undef
  if ($install_type == 'venv') {
    $_venv = $venv_path
  }

  python::pip { $package_name:
    ensure     => $package_version,
    url        => $_url,
    virtualenv => $_venv,
    subscribe  => $_subscribe,
  }
}
