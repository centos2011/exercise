class exer2 {
  
  ## Install httpd, git and vim
  Package { ensure => 'installed'
  }
  
  $installpackages = [ 'httpd', 'git'] 
  
  package { $installpackages:
  }

  package {'vim':
    ensure => installed,
    allow_virtual => true,
  }
}
