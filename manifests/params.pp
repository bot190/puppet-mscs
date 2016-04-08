# default parameters

class mscs::params {
    $mscs_user                        = 'minecraft'
    $mscs_group                       = 'minecraft'
    $mscs_revision                    = undef
    $mscs_location                    = '/opt/minecraft'
    $mscs_install_location            = "$mscs_location/mscs"
    $mscs_world_location              = '$LOCATION/worlds'
    $mscs_disabled_world_location     = '$LOCATION/worlds-disabled'
    $mscs_default_world               = 'world'
    $mscs_default_port                = 25565
    $mscs_default_ip                  = ''
    $mscs_default_version_type        = 'release'
    $mscs_default_client_version      = '$CURRENT_VERSION'
    $mscs_default_client_jar          = '$CLIENT_VERSION.jar'
    $mscs_default_client_url          = 'https://s3.amazonaws.com/Minecraft.Download/versions/$CLIENT_VERSION/$CLIENT_VERSION.jar'
    $mscs_default_client_location     = '$LOCATION\'/client/$CLIENT_VERSION\''
    $mscs_default_server_version      = '$CURRENT_VERSION'
    $mscs_default_server_jar          = 'minecraft_server.$SERVER_VERSION.jar'
    $mscs_default_server_url          = 'https://s3.amazonaws.com/Minecraft.Download/versions/$SERVER_VERSION/minecraft_server.$SERVER_VERSION.jar'
    $mscs_default_server_args         = 'nogui'
    $mscs_default_initial_memory      = '128M'
    $mscs_default_maximum_memory      = '2048M'
    $mscs_default_server_location     = '$LOCATION\'/server\''
    $mscs_default_server_command      = '$JAVA -Xms$INITIAL_MEMORY -Xmx$MAXIMUM_MEMORY -jar $SERVER_LOCATION/$SERVER_JAR $SERVER_ARGS'
    $mscs_minecraft_versions_url      = 'https://s3.amazonaws.com/Minecraft.Download/versions/versions.json'
    $mscs_versions_json               = '$DEFAULT_SERVER_LOCATION/versions.json'
    $mscs_version_duration            = 1440
    $mscs_backup_location             = '$LOCATION/backups'
    $mscs_backup_log                  = '$BACKUP_LOCATION/backup.log'
    $mscs_backup_duration             = 15
    $mscs_log_duration                = 15
    $mscs_detailed_listing_props      = 'motd server-ip server-port max-players level-type online-mode'
    $mscs_enable_mirror               = 0
    $mscs_mirror_path                 = '/dev/shm/mscs'
    $mscs_overviewer_bin              = '$(which overviewer.py)'
    $mscs_overviewer_url              = 'http://overviewer.org'
    $mscs_maps_url                    = 'http://minecraft.server.com/maps'
    $mscs_maps_location               = '$LOCATION/maps'


    $mc_properties  = {
        "level-name"    => { value   => $mscs_default_world},
        "server-port"   => { value   => $mscs_default_port},
        "server-ip"     => { value   => $mscs_default_server_ip},
        "enable-query"  => { value   => "true"},
        "query.port"    => {  value   => $mscs_default_port},
    }
    $mscs_properties = {
        "mscs-enabled"  => { value   => "true"},
    }

}
