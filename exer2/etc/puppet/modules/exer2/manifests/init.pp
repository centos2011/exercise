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
  
  ## Get file memory_check from github
  exec{'get_file':
    command => "/usr/bin/wget -q https://rawgit.com/centos2011/exercise/master/exer1/check_memory -O /home/monitor/scripts/memory_check",
  }

  file{'/home/monitor/scripts/memory_check':
    mode => 0755,
    require => Exec["get_file"],
    ensure => 'file',
  }

  ## Create directory src
  file { [ '/home/monitor/src/' ]:
    ensure => 'directory',
  }

}
