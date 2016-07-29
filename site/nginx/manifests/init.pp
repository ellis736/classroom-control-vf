class nginx(
 $package::$nginx::params::package,
 $owner::$nginx::params::owner,
 $group::$nginx::params::group,
 $default_docroot::$nginx::params::default_docroot,
 $confdir::$nginx::params::confdir,
 $logdir::$nginx::params::logdir,
 $user::$nginx::params::user
 ) inherits nginx::params {
 
  File {
   owner => $owner,
   group => $group,
   mode => '0644',
  }
   
  package { $package:
   ensure => present,
  }
  
  file {[$docroot, "$confdir/conf.d"]:
   ensure => directory,
  }
  
  file { "$docroot/index.html":
   ensure => file,
   source => 'puppet:///modules/nginx/index.html',
   }
   
  file { "$confdir/nginx.conf":
   ensure => file,
   #source => 'puppet:///modules/nginx/nginx.conf',
   content => template('nginx/nginx.conf.erb'),
   require => Package[$package],
   notify => Service['nginx'],
   }
  
  file { "$confdir/conf.d/default.conf":
     ensure => file,
    #source => 'puppet:///modules/nginx/default.conf',
     content => template('nginx/default.conf.erb'),
     require => Package[$package],
     notify => Service['nginx'],
     }
     
     service {'nginx':
      ensure => running,
      enable => true,
      }
  }
