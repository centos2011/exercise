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

  ## Create softlink my_memory
  exec { 'Create softlink':
    command => '/bin/ln -s /home/monitor/scripts/memory_check /home/monitor/src/my_memory_check',
    path => '/home/monitor/src/',
  }

  ## Create cron job
  cron { 'update_cron':
    ensure  => 'present',
    command => '/home/monitor/src/my_memory_check',
    user => 'root',
    minute => '*/10',
  }

  ## Set timezone to PHT
  file {
    "/etc/localtime":
    ensure => "/usr/share/zoneinfo/Asia/Manila",
  }

## Set hostname without reboot
  exec { "apply_hostname":
    command => "/bin/hostname bpx.server.local",
  }

  ## Set hostname permanently to survive even after reboot
  file { '/etc/sysconfig/network':
    ensure => present,
  }->
  file_line { 'Replace HOSTNAME from /etc/sysconfig/network':
    path => '/etc/sysconfig/network',
    line => 'HOSTNAME=bpx.server.local',
    match   => "^HOSTNAME.*$",
  }
}
