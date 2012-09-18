class chromedriver(
  $source = 'http://chromedriver.googlecode.com/files/chromedriver_linux32_23.0.1240.0.zip',
  $shasum = '988e47718972f650c96dc46f4ea1f5b4ed94f06f',
  $dest   = '/usr/local/bin/chromedriver',
  $cwd    = '/tmp',
) {
  Exec {
    onlyif => "test ! -x ${dest}",
    path   => ['/bin', '/sbin', '/usr/bin', '/usr/sbin', '/usr/local/bin'],
    cwd    => $cwd,
  }

  if $source =~ /([^\/ ]+)$/ {
    $filename = $1
  }

  $extractor = "unzip"
  $verifier  = "test $(shasum -a 1 ${filename} | cut -d ' ' -f 1) ="

  package { 'unzip': ensure => installed }

  exec { "chromedriver::download ${source}":
    command => "wget -q ${source} -O ${filename}",
    creates => "${cwd}/${filename}",
  }

  exec { "chromedriver::download::verify ${cwd}/${filename} ${shasum}":
    command => "${verifier} '${shasum}' || (rm -f ${filename} && false)",
  }

  exec { "chromedriver::download::extract ${cwd}/${filename}":
    command => "${extractor} ${filename}",
    creates => "${cwd}/chromedriver",
    require => Package['unzip'],
  }

  exec { "chromedriver::install ${cwd}/chromedriver ${dest}":
    command => "mv chromedriver ${dest}",
    creates => "${dest}",
  }

  exec { "chromedriver::cleanup ${cwd}/${filename}":
    command => "rm -f ${filename}",
    onlyif  => "test -e ${filename}",
  }

  Exec["chromedriver::download ${source}"]
    -> Exec["chromedriver::download::verify ${cwd}/${filename} ${shasum}"]
    -> Exec["chromedriver::download::extract ${cwd}/${filename}"]
    -> Exec["chromedriver::install ${cwd}/chromedriver ${dest}"]
    -> Exec["chromedriver::cleanup ${cwd}/${filename}"]
}
