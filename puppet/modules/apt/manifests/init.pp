# Class: apt
#
# This module manages the initial configuration of apt.
#
# Parameters:
#   The parameters listed here are not required in general and were
#   added for use cases related to development environments.
#
#   disable_keys        - do not require packages to be signed
#   always_apt_update   - apt-get update on every run,
#                         intended for development environments where
#                         package updates are frequent
#   purge_sources_list  - if set to true, Puppet will purge all unmanaged
#                         entries from sources.list. default: false
#   purge_sources_list_d - if set to true, Puppet will purge all unmanaged
#                         entries from sources.list.d. default: false
#
# Actions:
#   -
#
# Requires:
#   puppetlabs/stdlib
#
# Sample Usage:
#   class { 'apt': }
class apt(
  $always_apt_update    = false,
  $disable_keys         = undef,
  $proxy_host           = false,
  $proxy_port           = '8080',
  $purge_sources_list   = false,
  $purge_sources_list_d = false,
  $purge_preferences_d  = false
) {
  include apt::params
  include apt::update

  File {
    owner => 'root',
    group => 'root',
  }

  validate_bool($purge_sources_list, $purge_sources_list_d, $purge_preferences_d)

  $sources_list_content = $purge_sources_list ? {
    false => undef,
    true  => "# Repos managed by puppet.\n",
  }

  if $always_apt_update {
    Exec <| title=='apt-update' |> { refreshonly => false }
  }

  $root           = $apt::params::root
  $apt_conf_d     = $apt::params::apt_conf_d
  $sources_list_d = $apt::params::sources_list_d
  $preferences_d  = $apt::params::preferences_d
  $provider       = $apt::params::provider

  file { 'sources.list':
    ensure  => present,
    mode    => '0644',
    path    => "${root}/sources.list",
    content => $sources_list_content,
    notify  => Exec['apt-update'],
  }

  file { 'sources.list.d':
    ensure  => directory,
    path    => $sources_list_d,
    purge   => $purge_sources_list_d,
    recurse => $purge_sources_list_d,
    notify  => Exec['apt-update'],
  }

  file { 'preferences.d':
    ensure  => directory,
    path    => $preferences_d,
    purge   => $purge_preferences_d,
    recurse => $purge_preferences_d,
  }

  case $disable_keys {
    true: {
      file { '99unauth':
        ensure  => present,
        content => "APT::Get::AllowUnauthenticated 1;\n",
        path    => "${apt_conf_d}/99unauth",
      }
    }
    false: {
      file { '99unauth':
        ensure => absent,
        path   => "${apt_conf_d}/99unauth",
      }
    }
    undef:   { } # do nothing
    default: { fail('Valid values for disable_keys are true or false') }
  }

  if ($proxy_host) {
    file { 'configure-apt-proxy':
      path    => "${apt_conf_d}/proxy",
      content => "Acquire::http::Proxy \"http://${proxy_host}:${proxy_port}\";",
      notify  => Exec['apt-update'],
    }
  }

  # anchor to provide containment for dependencies
  anchor { 'apt::update': require => Class['apt::update'] }
}
