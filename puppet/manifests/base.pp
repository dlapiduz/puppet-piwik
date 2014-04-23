# Class: base
#
#
class base {

    Package { ensure => installed, }
    package { "wget": }

}