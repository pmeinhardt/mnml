define rbenv::install(
  $user  = 'vagrant',
  $group = 'vagrant',
  $home  = '/home/vagrant',
) {
  if ! defined(Class['rbenv::dependecies']) {
    require rbenv::dependencies
  }

  Exec { path => ['/bin', '/usr/bin', '/usr/sbin'] }

  $dest    = "${home}/.rbenv"
  $rbenvrc = "${home}/.rbenvrc"
  $bashrc  = "${home}/.bashrc"

  exec { "rbenv::clone ${user}":
    command => "git clone git://github.com/sstephenson/rbenv.git ${dest}",
    user    => $user,
    group   => $group,
    creates => $dest,
    timeout => 100,
    require => Package['git-core'],
  }

  file { "rbenv::rbenvrc ${user}":
    path    => $rbenvrc,
    owner   => $user,
    group   => $group,
    mode    => '0644',
    content => template('rbenv/rbenvrc.erb'),
  }

  exec { "rbenv::bashrc ${user}":
    command => "echo 'source ${rbenvrc}' >> ${bashrc}",
    user    => $user,
    group   => $group,
    unless  => "grep -q rbenvrc ${bashrc}",
    require => File["rbenv::rbenvrc ${user}"],
  }
}
