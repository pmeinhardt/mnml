class apt::backports(
  $release  = $::lsbdistcodename,
  $location = $apt::params::backports_location
) {
  include apt::params

  $release_real = downcase($release)
  $key = $::lsbdistid ? {
    'debian' => '55BE302B',
    'ubuntu' => '437D05B5',
  }
  $repos = $::lsbdistid ? {
    'debian' => 'main contrib non-free',
    'ubuntu' => 'main universe multiverse restricted',
  }

  apt::source { 'backports':
    location   => $location,
    release    => "${release_real}-backports",
    repos      => $repos,
    key        => $key,
    key_server => 'pgp.mit.edu',
    pin        => '200',
  }
}
