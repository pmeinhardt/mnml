class rbenv(
  $user    = 'vagrant',
  $group   = 'vagrant',
  $home    = '/home/vagrant',
  $rubyver = '1.9.3-p194',
) {
  if ! defined(Class['rbenv::dependecies']) {
    require rbenv::dependencies
  }

  rbenv::install { "rbenv ${user}":
    user   => $user,
    group  => $group,
    home   => $home,
  }

  rbenv::plugin { "ruby-build ${user}":
    name   => 'ruby-build',
    source => 'git://github.com/sstephenson/ruby-build.git',
    user   => $user,
    group  => $group,
    home   => $home,
  }

  rbenv::compile { "ruby ${rubyver} ${user}":
    user    => $user,
    group   => $group,
    home    => $home,
    rubyver => $rubyver,
    global  => true,
  }

  Rbenv::Install["rbenv ${user}"]
    -> Rbenv::Plugin["ruby-build ${user}"]
    -> Rbenv::Compile["ruby ${rubyver} ${user}"]
}
