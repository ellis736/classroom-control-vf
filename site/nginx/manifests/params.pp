class nginx::params {
case $::osfamily {
  'redhat': {
   $package = 'nginx'
   $owner = 'root'
   $group = 'root'
   #$docroot = '/var/www'
   $default_docroot ='/var/www'
   $confdir = '/etc/nginx'
   $logdir = '/var/log/nginx'
   $user= 'nginx'
   }
   'debian': {
   $package = 'nginx'
   $owner = 'root'
   $group = 'root'
   #$docroot = '/var/www'
   $default_docroot ='/var/www'
   $confdir = '/etc/nginx'
   $logdir = '/var/log/nginx'
   $user= 'www-data'
   }
  'windows': {
  $package = 'nginx-service'
  $owner = 'Administrator'
  $group = 'Administrators'
  #$docroot = 'C:/ProgramData/nginx/html'
  $default_docroot = 'C:/ProgramData/nginx/html'
  $confdir = 'C:/ProgramData/nginx'
  $logdir = ' C:/ProgramData/nginx/log'
  $user = 'nobody'
  }
  default : {
fail("Module ${module_name} is not supported on ${::osfamily}")
  }
}
  # If $root isn't set, then fall back to the platform default
  $docroot = $root ? {
  undef => $default_docroot,
  default => $root,
  }
}
