define users::managed_user (
 $group=$title
){
user {$title:
  ensure => present,
 }
file { "/home/$title":
  ensure =>directory,
  owner => $title,
  group => $group,
 }
 file { "/home/$title/.ssh":
 ensure =>file,
 owner => $title,
 group => $group,
 mode => '0664',
 }
}
