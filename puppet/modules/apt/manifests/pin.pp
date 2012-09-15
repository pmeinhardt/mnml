define apt::pin(
  $ensure     = present,
  $packages   = '*',
  $priority   = 0,
  $release    = '',
  $origin     = '',
  $originator = '',
  $version    = ''
) {
  include apt::params

  $preferences_d = $apt::params::preferences_d

  File {
    ensure => $ensure,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }

  if $release != '' {
    $pin = "release a=${release}"
  } elsif $origin != '' {
    $pin = "origin \"${origin}\""
  } elsif $originator != '' {
    $pin = "release o=${originator}"
  } elsif $version != '' {
    $pin = "version ${version}"
  } else {
    $pin = "release a=${name}"
  }

  file { "${name}.pref":
    path    => "${preferences_d}/${name}.pref",
    content => template('apt/pin.pref.erb'),
  }
}
