class profile::example {
 include apache
 include wordpress
 include ::mysql::server
 
  notify { 'This is the example profile!': }
}

