class user::admins {
  users::managed_user {'jose':}
  users::managed_user {'alice':}
  users::managed_user {'chen':
    group => 'admin',
  }
  gourp { 'admin':
   ensure => present,
  }
}
