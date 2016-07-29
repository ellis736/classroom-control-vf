class profile::example {
 include apache
 include wordpress
 
  notify { 'This is the example profile!': }
}

