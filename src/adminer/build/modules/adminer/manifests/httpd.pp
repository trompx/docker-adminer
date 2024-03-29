class adminer::httpd {
  require adminer::httpd::packages
  require adminer::httpd::supervisor

  bash_exec { 'a2enmod actions': }
  bash_exec { 'a2enmod proxy_fcgi': }
  bash_exec { 'a2enmod vhost_alias': }
  bash_exec { 'a2enmod rewrite': }
  bash_exec { 'a2enmod ssl': }
  bash_exec { 'a2enmod headers': }

  file { '/var/www/index.html':
    ensure => absent
  }

  file { '/etc/apache2/sites-enabled/000-default.conf':
    ensure => absent
  }

  file { '/etc/apache2/conf-available/logs.conf':
    ensure => present,
    source => 'puppet:///modules/adminer/etc/apache2/conf-available/logs.conf',
    mode => 644
  }

  file { '/etc/apache2/conf-enabled/logs.conf':
    ensure => link,
    target => '/etc/apache2/conf-available/logs.conf',
    require => File['/etc/apache2/conf-available/logs.conf']
  }
}
