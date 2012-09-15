define rbenv::compile(
  $user    = 'vagrant',
  $group   = 'vagrant',
  $home    = '/home/vagrant',
  $rubyver = '1.9.3-p194',
  $global  = false,
) {
  if ! defined(Class['rbenv::dependecies']) {
    require rbenv::dependencies
  }

  # make sure to have "ruby-build" installed before

  $root = "${home}/.rbenv"

  Exec {
    user        => $user,
    group       => $group,
    path        => ["${root}/shims", "${root}/bin", '/bin', '/usr/bin'],
    environment => ["HOME=${home}"],
  }

  exec { "rbenv::compile ${rubyver} ${user}":
    command => "rbenv install ${rubyver}; touch ${root}/.rehash",
    unless  => "rbenv versions | grep -q ${rubyver}",
    timeout => 0, # disabled for compilation
    before  => [
      Exec["rbenv::rehash ${user}"],
      Exec["rbenv::global ${rubyver} ${user}"],
    ],
  }

  exec { "rbenv::rehash ${user}":
    command => "rbenv rehash; rm -f ${root}/.rehash",
    onlyif  => "test -e '${root}/.rehash'",
    before  => [
      Exec["rbenv::bundler ${rubyver} ${user}"],
      Exec["rbenv::global ${rubyver} ${user}"],
    ],
  }

  exec { "rbenv::bundler ${rubyver} ${user}":
    command => 'gem install bundler',
    unless  => 'gem list bundler | grep -q bundler',
  }

  if $global {
    exec { "rbenv::global ${rubyver} ${user}":
      command => "rbenv global ${rubyver}",
      unless  => "rbenv global | grep -q ${rubyver}",
    }
  }
}
