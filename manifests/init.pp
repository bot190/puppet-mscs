# Class: mscs
# ===========================
#
# This class installs and configures the Minecraft Server Control Script. 
#
# Parameters
# ----------
#
# * `mscs_user`
#  User to run MSCS, and the Minecraft servers as
# * `mscs_group`
#  Group to run MSCS, and the Minecraft servers as
# * `service_ensure`
#  Whether or not the MSCS service should be installed
# * `service_manage`
#  Whether or not the service is controlled by Puppet
# * `service_enable`
#  Whether or not the service should be enabled
# * `service_name`
#  The name of the service
# * `manage_dirs`
#  Whether or not this module should create the server directories.
# * `mscs_revision`
#  A valid github commit identifier to specify which version of the script should be used.
# * `mscs_install_location`
#  Where the MSCS scripts will be downloaded to
#  * Default: '/opt/minecraft/mscs/
# * `mscs_location`
#  Location of Minecraft server files
# * `mscs_world_location`
#  Location of Minecraft worlds
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'mscs':
#    }
#
# Authors
# -------
#
# Ben Beauregard <bot190@gmail.com>
#
# Copyright
# ---------
#
# Copyright 2016 Ben Beauregard
#
class mscs (
    $mscs_user                      = $mscs::params::mscs_user,
    $mscs_group                     = $mscs::params::mscs_group,
    $service_ensure                 = 'running',
    $service_manage                 = true,
    $service_enable                 = true,
    $service_name                   = 'mscs',
    $manage_dirs                    = true,
    $mscs_revision                  = $mscs::params::mscs_revision,
    $mscs_install_location          = $mscs::params::mscs_install_location, 
    $mscs_location                  = $mscs::params::mscs_location, 
    $mscs_world_location            = $mscs::params::mscs_world_location, 
    $mscs_disabled_world_location   = $mscs::params::mscs_disabled_world_location,
    $mscs_default_world             = $mscs::params::mscs_default_world,
    $mscs_default_port              = $mscs::params::mscs_default_port,
    $mscs_default_ip                = $mscs::params::mscs_default_ip,
    $mscs_default_version_type      = $mscs::params::mscs_default_version_type,
    $mscs_default_client_version    = $mscs::params::mscs_default_client_version,
    $mscs_default_client_jar        = $mscs::params::mscs_default_client_jar,
    $mscs_default_client_url        = $mscs::params::mscs_default_client_url,
    $mscs_default_client_location   = $mscs::params::mscs_default_client_location,
    $mscs_default_server_version    = $mscs::params::mscs_default_server_version,
    $mscs_default_server_jar        = $mscs::params::mscs_default_server_jar,
    $mscs_default_server_url        = $mscs::params::mscs_default_server_url,
    $mscs_default_server_args       = $mscs::params::mscs_default_server_args,
    $mscs_default_initial_memory    = $mscs::params::mscs_default_initial_memory,
    $mscs_default_maximum_memory    = $mscs::params::mscs_default_maximum_memory,
    $mscs_default_server_location   = $mscs::params::mscs_default_server_location,
    $mscs_default_server_command    = $mscs::params::mscs_default_server_command,
    $mscs_minecraft_versions_url    = $mscs::params::mscs_minecraft_versions_url,
    $mscs_versions_json             = $mscs::params::mscs_versions_json,
    $mscs_versions_duration         = $mscs::params::mscs_version_duration,
    $mscs_backup_location           = $mscs::params::mscs_backup_location,
    $mscs_backup_log                = $mscs::params::mscs_backup_log,
    $mscs_backup_duration           = $mscs::params::mscs_backup_duration,
    $mscs_log_duration              = $mscs::params::mscs_log_duration,
    $mscs_detailed_listing_props    = $mscs::params::mscs_detailed_listing_props,
    $mscs_enable_mirror             = $mscs::params::mscs_enable_mirror,
    $mscs_mirror_path               = $mscs::params::mscs_mirror_path,
    $mscs_overviewer_bin            = $mscs::params::mscs_overviewer_bin,
    $mscs_overviewer_url            = $mscs::params::mscs_overviewer_url,
    $mscs_maps_url                  = $mscs::params::mscs_maps_url,
    $mscs_maps_location             = $mscs::params::mscs_maps_location,

) inherits ::mscs::params {
    # Validate parameters
    validate_bool($service_manage)
    validate_bool($service_enable)

    # Ensure server location exists
    if $manage_dirs == true {
        file { [ $mscs_location, $mscs_install_location ]:
            ensure => 'directory',
            owner  => $mscs_user,
            group  => $mscs_group,
            mode   => '0755',
        }
    }
    # Pull git repository at the given revision
    vcsrepo { $mscs_install_location:
        ensure      => 'present',
        provider    => git,
        source      => 'https://github.com/MinecraftServerControl/mscs.git',
        user        => 'minecraft',
        revision    => $mscs_revision,
        require     => File[$mscs_install_location],
    }
    # Move files to respective locations
    file { '/usr/local/bin/msctl':
        ensure  => 'present',
        source  => "$mscs_install_location/msctl",
        mode    => '0755',
        owner  => $mscs_user,
        group  => $mscs_group,
        require => Vcsrepo[$mscs_install_location],
    }
    file { '/usr/local/bin/mscs':
        ensure => 'present',
        source => "$mscs_install_location/mscs",
        mode   => '0755',
        require => Vcsrepo[$mscs_install_location],
    }
    file { "/etc/systemd/system/$service_name.service":
        ensure => 'present',
        source => "$mscs_install_location/mscs.service",
        mode   => '0644',
        require => Vcsrepo[$mscs_install_location],
    }
    file { '/etc/bash_completion.d/mscs':
        ensure => 'present',
        source => "$mscs_install_location/mscs.completion",
        mode   => '0644',
        require => Vcsrepo[$mscs_install_location],
    }

    # If using the default world location, then determine absolute install path assuming default world location
    if $mscs::mscs_world_location == $mscs::params::mscs_world_location {
        $world_location = "$mscs_location/worlds"
    } else {
        $world_location = $mscs_world_location
    }
    # Create world folder
    file { $world_location:
        ensure  => 'directory',
        mode    => '0755',
        owner  => $mscs_user,
        group  => $mscs_group,
    }
    
    # Create global config file
    file { '/etc/default/mscs':
        ensure  => 'present',
        mode    => '0644',
        owner  => $mscs_user,
        content => template("${module_name}/mscs.erb"),
    }

    # Manage MSCS service if required
    if $service_manage == true {
        service { $service_name:
            enable  => $service_enable,
            ensure  => $service_ensure,
            name    => $service_name,
            require => [ File["/etc/systemd/system/$service_name.service"], File["/etc/default/mscs"] ],
        }
    }
}
