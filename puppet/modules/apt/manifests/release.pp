class apt::release(
  $release_id
) {
  include apt::params

  $root = $apt::params::root

  File {
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }

  file { "${root}/apt.conf.d/01release":
    content => "APT::Default-Release \"${release_id}\";"
  }
}
