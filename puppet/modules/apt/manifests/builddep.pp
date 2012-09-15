define apt::builddep {
  include apt::update

  Exec { logoutput => 'on_failure' }

  exec { "apt-builddep-${name}":
    command => "/usr/bin/apt-get -y --force-yes build-dep ${name}",
    notify  => Exec['apt-update'],
  }

  # anchor to provide containment for dependencies
  anchor { "apt::builddep::${name}": require => Class['apt::update'] }
}
