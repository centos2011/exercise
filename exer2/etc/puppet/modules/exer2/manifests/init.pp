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

  ## Create user
  user { 'monitor':
    ensure => present,
    comment => 'user',
    home => '/home/monitor',
    managehome => true
  }

  ## Create a directory scripts/
  file { [ '/home/monitor/', '/home/monitor/scripts/' ]:
    ensure => 'directory',
  }
}
