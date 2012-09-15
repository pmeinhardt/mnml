class postgres {
  package { 'postgresql': ensure => installed }
  package { 'libpq-dev': ensure => installed }
}
