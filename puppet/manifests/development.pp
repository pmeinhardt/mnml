# Default puppet configuration

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
  include postgres

  # additional packages

  # include redis     # include if you're using redis through resque, …
  # include magick    # in case you're using paperclip or carrierwave or …

  include dotfiles
}
