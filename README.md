# mscs

#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with mscs](#setup)
    * [What mscs affects](#what-mscs-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with mscs](#beginning-with-mscs)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)

## Description

This module installs and manages the Minecraft server using the Minecraft Server Control Script.
The module is currently being used on a Debian Jessie (8.x) installation, but should work 
fairly universally.

The module will download the MSCS script from Github, and install it. It can be 
used to configure global settings for the script. Additionally, control of 
individual Minecraft servers is available through the World type. 

More information on MSCS can be found on Github at: 
https://github.com/MinecraftServerControl/mscs

## Setup

### Setup Requirements

This module depends upon:
* VscRepo
* Augeas

This module does NOT attempt to satisfy all of the requirements of MSCS.
You will need to ensure that any software required is available on your system.
Currently that list includes (Note that this is not maintained):
* Java JRE     - The Minecraft server software requires this.
* Perl         - Most, if not all, Unix and Linux like systems have this
                 preinstalled.
* libjson-perl - Allows the script to read JSON formatted data.
* Python       - Required by the Minecraft Overviewer mapping software.
* GNU Make     - Allows you to use the Makefile to simplify installation.
* GNU Wget     - Allows the script to download software updates via the
                 internet.
* rdiff-backup - Allows the script to efficiently run backups.
* Socat        - Allows the script to communicate with the Minecraft server.
* Iptables     - Although not explicitly required, a good firewall should be
                 installed.

### Beginning with mscs

This module can used with the default options by simply including it:
<pre>
include mscs
</pre>

## Usage

This section is where you describe how to customize, configure, and do the
fancy stuff with your module here. It's especially helpful if you include usage
examples and code samples for doing things with your module.

## Reference

### Class mscs

 * `mscs_user`
  User to run MSCS, and the Minecraft servers as
 * `mscs_group`
  Group to run MSCS, and the Minecraft servers as
 * `service_ensure`
  Whether or not the MSCS service should be installed
 * `service_manage`
  Whether or not the service is controlled by Puppet
 * `service_enable`
  Whether or not the service should be enabled
 * `service_name`
  The name of the service
 * `manage_dirs`
  Whether or not this module should create the server directories.
 * `mscs_revision`
  A valid github commit identifier to specify which version of the script should be used.
 * `mscs_install_location`
  Where the MSCS scripts will be downloaded to
  * Default: '/opt/minecraft/mscs/
 * `mscs_location`
  Location of Minecraft server files
 * `mscs_world_location`
  Location of Minecraft worlds

### type: mscs::world
Used to define a standalone Minecraft server.

