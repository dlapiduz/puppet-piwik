class piwik(
    $path        = "/www/",
    $user        = "www-data",
) {
    file { $path:
        ensure => "directory",
        owner => $user,
    }->
    exec { "download":
        path => "/bin:/usr/bin",
        creates => "/tmp/latest.tar.gz",
        command => "bash -c 'cd /tmp; wget http://builds.piwik.org/latest.tar.gz'",
        user => $user,
    }->
    exec { "unpackage":
        path => "/bin:/usr/bin",
        creates => "/",
        command => "bash -c 'tar xfz /tmp/latest.tar.gz -C ${$path}'",
        user => $user,
    }->
    file { "/tmp/latest.tar.gz":
        ensure => absent,
    }

    php::ini { '/etc/php.ini':
        display_errors => 'On',
        memory_limit   => '256M',
    }
    php::mod_php5 {}
    php::module { [ 'mysql', 'mcrypt', 'gd' ]: }
}
