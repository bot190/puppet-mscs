# Provider: mscsproperties
# ===========================
#
# Define Augeas Provider for editing mscs.properties
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

define mscs::mscsproperties ( $value, $world_location, $world_title ) {
    include mscs

    # $title contains title of each instance of this type

    # guid of this entry
    $key = $title

    $context = "/files${world_location}/${world_title}/mscs.properties"

    augeas {  "${world_title}/$key":
        incl    => "/${world_location}/${world_title}/mscs.properties",
        lens    => "Properties.lns",
        context => "$context",
        onlyif  => "get $key != '$value'",
        changes => "set $key '$value'",
        notify  => Exec[ "/usr/local/bin/mscs start $world_title"],
    }
}
