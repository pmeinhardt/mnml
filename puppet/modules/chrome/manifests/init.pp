class chrome(
  $channel = 'stable',
  $version = false,
) {
  include apt

  $key_source = 'https://dl-ssl.google.com/linux/linux_signing_key.pub'
  $location   = 'http://dl.google.com/linux/chrome/deb/'

  $version_string = $version ? {
    false   => undef,
    default => "=${version}",
  }

  apt::source { 'google':
    ensure            => present,
    key               => '7FAC5991',
    key_source        => $key_source,
    location          => $location,
    release           => 'stable',
    repos             => 'main',
    include_src       => false,
    required_packages => "google-chrome-${channel}${version_string}",
  }
}
