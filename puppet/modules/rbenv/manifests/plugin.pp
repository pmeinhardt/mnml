define rbenv::plugin(
  $name   = $title,
  $source = '',
  $user   = 'vagrant',
  $group  = 'vagrant',
  $home   = '/home/vagrant',
) {
  if ! defined(Class['rbenv::dependecies']) {
    require rbenv::dependencies
  }

  if $source !~ /^git:/ {
    fail("Rbenv plugins can only be installed via git repositories: ${source}")
  }

  Exec { path => ['/bin', '/usr/bin', '/usr/sbin'] }

  $root = "${home}/.rbenv/plugins"
  $dest = "${root}/${name}"

  file { "rbenv::plugin::dir ${user}":
    ensure  => directory,
    path    => $root,
    owner   => $user,
    group   => $group,
    mode    => '0755',
    require => Exec["rbenv::clone ${user}"],
  }

  exec { "rbenv::plugin::clone ${user} ${name}":
    command => "git clone ${source} ${dest}",
    user    => $user,
    group   => $group,
    creates => $dest,
    timeout => 100,
    require => File["rbenv::plugin::dir ${user}"],
  }
}
