# Define for MSCS world type
define mscs::world (
    $mc_properties      = undef,
    $mscs_properties    = undef,
    ) {
    include mscs
    include mscs::params

    # Get around the inability to inherit from a class by pulling in defaults if nothing was passed
    if $mc_properties == undef {
        $mc_properties_augeas = $mscs::params::mc_properties
    } else {
        $mc_properties_augeas = $mc_properties
    }
    if $mscs_properties == undef {
        $mscs_properties_augeas = $mscs::params::mscs_properties
    } else {
        $mscs_properties_augeas = $mscs_properties
    }

    # World will have same name as the title of this resource
    $world_title = $title;

    # If using the default world location, then determine absolute install path assuming default world location
    if $mscs::mscs_world_location == $mscs::params::mscs_world_location {
        $world_location = "$mscs::mscs_location/worlds"
    } else {
        $world_location = $mscs::mscs_world_location
    }
    
    file { "${world_location}/${world_title}":
        ensure      => directory,
        owner       => $mscs::mscs_user,
        group       => $mscs::mscs_group,
        mode        => '0755',
    }
    file { "${world_location}/${world_title}/server.properties":
        ensure      => present,
        owner       => $mscs::mscs_user,
        group       => $mscs::mscs_group,
        mode        => '0755',
    }
    file { "${world_location}/${world_title}/mscs.properties":
        ensure      => present,
        owner       => $mscs::mscs_user,
        group       => $mscs::mscs_group,
        mode        => '0755',
    }
    notify {"$world_location: $world_title":}
    $world_info = {
        'world_title'       => $world_title,
        'world_location'    => $world_location,
    }   
    # Create Augeas resources for each key specified in server.properties
    create_resources("mscs::mcproperties", $mc_properties_augeas, $world_info)
    
    # Create Augeas resources for each key specified in mscs.properties
    create_resources("mscs::mscsproperties", $mscs_properties_augeas, $world_info)

    exec { "/usr/local/bin/mscs start $world_title":
        refreshonly => true,
        command     => "/usr/local/bin/mscs start $world_title",
        user        => $mscs::mscs_user,
    }
}
