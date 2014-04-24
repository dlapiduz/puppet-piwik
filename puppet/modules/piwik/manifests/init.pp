class piwik(
    $path        = "/www/",
    $user        = "apache",
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
        creates => "/www/piwik/index.php",
        command => "bash -c 'tar xfz /tmp/latest.tar.gz -C ${$path}'",
        user => $user,
    }->
    file { "/tmp/latest.tar.gz":
        ensure => absent,
    }
}
