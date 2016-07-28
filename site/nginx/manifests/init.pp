class nginx {
  
  case $::osfamily {
  'redhat': {
   $package = 'nginx'
   $owner = 'root'
   $group = 'root'
   $docroot = '/var/www'
   $confdir = '/etc/nginx'
   $logdir = '/var/logs/nginx'
   $user= 'nginx'
   }
   'debian': {
   $package = 'nginx'
   $owner = 'root'
   $group = 'root'
   $docroot = '/var/www'
   $confdir = '/etc/nginx'
   $logdir = '/var/logs/nginx'
   $user= 'www-data'
   }
  'windows': {
  $package = 'nginx-service'
  $owner = 'Administrator'
  $group = 'Administrators'
  $docroot = 'C:/ProgramData/nginx/html'
  $confdir = 'C:/ProgramData/nginx'
  $logdir = ' C:/ProgramData/nginx/logs'
  $user = 'nobody'
  }
  default : {
fail("Module ${module_name} is not supported on ${::osfamily}")
  }
}

  File {
   owner => '$owner',
   group => '$group',
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
   notify => Service['nginx'],
   }
  
  file { "$confdir/conf.d/default.conf":
     ensure => file,
     source => 'puppet:///modules/nginx/default.conf',
     content => template('nginx/default.conf.erb'),
     notify => Service['nginx'],
     }
     
     service {'nginx':
      ensure => running,
      enable => true,
      }
  }
