define apt::force(
  $release = 'testing',
  $version = false,
  $timeout = 300
) {
  Exec {
    timeout   => $timeout,
    logoutput => 'on_failure',
  }

  $version_string = $version ? {
    false   => undef,
    default => "=${version}",
  }

  $installed = $version ? {
    false   => "/usr/bin/dpkg -s ${name} | grep -q 'Status: install'",
    default => "/usr/bin/dpkg -s ${name} | grep -q 'Version: ${version}'",
  }
  exec { "/usr/bin/aptitude -y -t ${release} install ${name}${version_string}":
    unless => $installed,
  }
}
