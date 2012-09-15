class apt::update {
  include apt::params

  Exec { logoutput => 'on_failure' }

  exec { 'apt-update':
    command     => "${apt::params::provider} update",
    refreshonly => true,
  }
}
