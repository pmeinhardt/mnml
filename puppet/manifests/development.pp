# Default puppet configuration

$psql_databases = ['mnml-dev', 'mnml-test', 'mnml-prod']

# define the run stages

stage { 'pre':  before  => Stage['main'] }
stage { 'post': require => Stage['main'] }

# immediate system classes

class sys::update {
  exec { '/usr/bin/apt-get update': }
}

# configure nodes

node default {
  class { 'sys::update': stage => 'pre' }

  # start setting up

  include stdlib
  include apt
  include git
  include vim
  include rbenv
  include nodejs
  include postgresql

  class { 'chrome':
    channel => 'unstable',
    version => '23.0.1262.0-r155673',
  }

  class { 'chromedriver': }

  # gem dependencies

  package { 'libpq-dev': ensure => installed }

  # database setup

  class { 'postgresql::server': }

  pg_database { $psql_databases:
    ensure    => present,
    encoding  => 'UTF8',
    require   => Class['postgresql::server']
  }

  pg_user { 'vagrant':
    ensure    => present,
    superuser => true,
    require   => Class['postgresql::server']
  }

  # additional packages

  # include redis       # include if you're using redis through resque, …
  # include memcached   # using memcached to store expensive objects …
  # include magick      # in case you're using paperclip or carrierwave or …

  # customize vm work environment

  include dotfiles
}
