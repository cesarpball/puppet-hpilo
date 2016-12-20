# vim:set noet:
# vim:set sts=8 ts=8:
# vim:set shiftwidth=8:

# = Class: ilo 
#
# iLO management from puppet. 
#
# == Parameters
#
# == Examples
#
# Usage:
#  include ilo 
#
# == Authors
#
# - Cesar Prieto Ballester <cesarprietoballester@piksel.com>
#
# == Copyright
#
class ilo {

	$username = hiera('ilo::ilo_username')
	$password = chomp(symmetric_decrypt(hiera('ilo::ilo_password')))

	file { '/opt/hp/puppet-ilo.conf':
	  ensure  => file,
	  audit => 'content',
	  notify => Exec['reset_ilo_password'],
	  content => template('ilo/puppet-ilo.conf.erb'),
	}

	exec { 'reset_ilo_password':
	  command     => '/sbin/hponcfg -f /opt/hp/puppet-ilo.conf',
	}

}

