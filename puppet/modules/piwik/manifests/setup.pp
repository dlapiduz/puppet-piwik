class piwik::setup {
    class { 'apache':
        default_confd_files => false,
        default_vhost       => false,
    }

    apache::listen { '80': }
    apache::listen { '443': }

    php::ini { '/etc/php.ini':
        display_errors => 'On',
        memory_limit   => '256M',
    }
    class { 'php::mod_php5': }
    php::module { [ 'mysql', 'gd', 'mbstring' ]: }

    apache::vhost { 'piwik':
        port    => '80',
        docroot => '/www/piwik',
    }

    mysql::db { 'piwik':
        user     => 'piwik',
        password => 'piwik123',
        host     => 'localhost',
        grant    => ['ALL'],
    }
}