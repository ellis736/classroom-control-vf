class users::admins {
  users::managed_user {'jose':}
  users::managed_user {'alice':
   group => 'admin'
   }
  
  users::managed_user {'chen':
    group => 'admin',
  }
  group { 'admin':
   ensure => present,
  }
}
