class dotfiles(
  $user  = 'vagrant',
  $group = 'vagrant',
  $home  = '/home/vagrant',
) {
  File {
    ensure => present,
    owner  => $user,
    group  => $group,
    mode   => '0644',
  }

  file { "${home}/.gemrc":
    content => template("${module_name}/gemrc.erb"),
  }

  file { "${home}/.irbrc":
    content => template("${module_name}/irbrc.erb"),
  }

  file { "${home}/.rdebugrc":
    content => template("${module_name}/rdebugrc.erb"),
  }

  file { "${home}/.gitconfig":
    content => template("${module_name}/gitconfig.erb")
  }

  file { "${home}/.gitignore":
    content => template("${module_name}/gitignore.erb")
  }
}
