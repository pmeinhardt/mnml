define apt::conf(
  $content,
  $ensure   = present,
  $priority = '50'
) {
  include apt::params

  $dir = $apt::params::apt_conf_d

  File {
    ensure => $ensure,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }

  file { "${dir}/${priority}${name}": content => $content }
}
