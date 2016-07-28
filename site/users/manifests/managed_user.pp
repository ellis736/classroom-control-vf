define users::managed_user (
 $group=$title
){
user {$title:
  ensure => present,
 }
file { "/home/$title":
  ensure =>directory,
  owner => $title,
  group => $title,
 }
 file { "/home/$title/.ssh":
 ensure =>file,
 owner => $title,
 group => $title,
 mode => '0664',
 }
}
