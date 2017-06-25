
exec { "apt-update":
    command => "/usr/bin/apt-get update"
}

package { "nginx":
    ensure => installed,
    require => Exec["apt-update"],
}

file { "/etc/nginx/nginx.conf":
    owner => root,
    group => root,
    mode => 0640,
    source => "/vagrant/manifests/nginx.conf",
    require => Package["nginx"],
}

file { '/var/www':
    ensure => 'directory',
    mode => 0755,
  }

file { '/var/www/dotnet-stack':
    ensure => 'directory',
    owner  => 'root',
    group  => 'www-data',
    mode => 0644,
    source => "/vagrant/manifests/dotnet-stack",
    recurse => 'remote',
}

service { "nginx":
    ensure => running,
    enable => true,
    hasstatus => true,
    hasrestart => true,
    require => Package["nginx"],
}