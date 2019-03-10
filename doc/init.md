Sample init scripts and service configuration for esmacoind
==========================================================

Sample scripts and configuration files for systemd, Upstart and OpenRC
can be found in the contrib/init folder.

    contrib/init/esmacoind.service:    systemd service unit configuration
    contrib/init/esmacoind.openrc:     OpenRC compatible SysV style init script
    contrib/init/esmacoind.openrcconf: OpenRC conf.d file
    contrib/init/esmacoind.conf:       Upstart service configuration file
    contrib/init/esmacoind.init:       CentOS compatible SysV style init script

1. Service User
---------------------------------

All three Linux startup configurations assume the existence of a "esmacoin" user
and group.  They must be created before attempting to use these scripts.
The OS X configuration assumes esmacoind will be set up for the current user.

2. Configuration
---------------------------------

At a bare minimum, esmacoind requires that the rpcpassword setting be set
when running as a daemon.  If the configuration file does not exist or this
setting is not set, esmacoind will shutdown promptly after startup.

This password does not have to be remembered or typed as it is mostly used
as a fixed token that esmacoind and client programs read from the configuration
file, however it is recommended that a strong and secure password be used
as this password is security critical to securing the wallet should the
wallet be enabled.

If esmacoind is run with the "-server" flag (set by default), and no rpcpassword is set,
it will use a special cookie file for authentication. The cookie is generated with random
content when the daemon starts, and deleted when it exits. Read access to this file
controls who can access it through RPC.

By default the cookie is stored in the data directory, but it's location can be overridden
with the option '-rpccookiefile'.

This allows for running esmacoind without having to do any manual configuration.

`conf`, `pid`, and `wallet` accept relative paths which are interpreted as
relative to the data directory. `wallet` *only* supports relative paths.

For an example configuration file that describes the configuration settings,
see `contrib/debian/examples/esmacoin.conf`.

3. Paths
---------------------------------

3a) Linux

All three configurations assume several paths that might need to be adjusted.

Binary:              `/usr/bin/esmacoind`  
Configuration file:  `/etc/esmacoin/esmacoin.conf`  
Data directory:      `/var/lib/esmacoind`  
PID file:            `/var/run/esmacoind/esmacoind.pid` (OpenRC and Upstart) or `/var/lib/esmacoind/esmacoind.pid` (systemd)  
Lock file:           `/var/lock/subsys/esmacoind` (CentOS)  

The configuration file, PID directory (if applicable) and data directory
should all be owned by the esmacoin user and group.  It is advised for security
reasons to make the configuration file and data directory only readable by the
esmacoin user and group.  Access to esmacoin-cli and other esmacoind rpc clients
can then be controlled by group membership.

3b) Mac OS X

Binary:              `/usr/local/bin/esmacoind`  
Configuration file:  `~/Library/Application Support/EsmacoinCore/esmacoin.conf`  
Data directory:      `~/Library/Application Support/EsmacoinCore`
Lock file:           `~/Library/Application Support/EsmacoinCore/.lock`

4. Installing Service Configuration
-----------------------------------

4a) systemd

Installing this .service file consists of just copying it to
/usr/lib/systemd/system directory, followed by the command
`systemctl daemon-reload` in order to update running systemd configuration.

To test, run `systemctl start esmacoind` and to enable for system startup run
`systemctl enable esmacoind`

4b) OpenRC

Rename esmacoind.openrc to esmacoind and drop it in /etc/init.d.  Double
check ownership and permissions and make it executable.  Test it with
`/etc/init.d/esmacoind start` and configure it to run on startup with
`rc-update add esmacoind`

4c) Upstart (for Debian/Ubuntu based distributions)

Drop esmacoind.conf in /etc/init.  Test by running `service esmacoind start`
it will automatically start on reboot.

NOTE: This script is incompatible with CentOS 5 and Amazon Linux 2014 as they
use old versions of Upstart and do not supply the start-stop-daemon utility.

4d) CentOS

Copy esmacoind.init to /etc/init.d/esmacoind. Test by running `service esmacoind start`.

Using this script, you can adjust the path and flags to the esmacoind program by
setting the ESMAD and FLAGS environment variables in the file
/etc/sysconfig/esmacoind. You can also use the DAEMONOPTS environment variable here.

4e) Mac OS X

Copy org.esmacoin.esmacoind.plist into ~/Library/LaunchAgents. Load the launch agent by
running `launchctl load ~/Library/LaunchAgents/org.esmacoin.esmacoind.plist`.

This Launch Agent will cause esmacoind to start whenever the user logs in.

NOTE: This approach is intended for those wanting to run esmacoind as the current user.
You will need to modify org.esmacoin.esmacoind.plist if you intend to use it as a
Launch Daemon with a dedicated esmacoin user.

5. Auto-respawn
-----------------------------------

Auto respawning is currently only configured for Upstart and systemd.
Reasonable defaults have been chosen but YMMV.
