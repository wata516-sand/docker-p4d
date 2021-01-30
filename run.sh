#!/bin/bash
set -e

#p4d | Usage: configure-helix-p4d.sh [service-name] [options]
#p4d |
#p4d | -n - Use the following flags in non-interactive mode
#p4d | -p <P4PORT> - Perforce Server's address
#p4d | -r <P4ROOT> - Perforce Server's root directory
#p4d | -u <username> - Perforce super-user login name
#p4d | -P <password> - Perforce super-user password
#p4d | --unicode - Enable unicode mode on server
#p4d | --case - Case-sensitivity (0=sensitive[default],1=insensitive)
#p4d | -h --help - Display this help and exit

if [ ! -f /etc/perforce/p4dctl.conf.d/$P4NAME.conf ]; then

#    /opt/perforce/sbin/configure-perforce-server.sh -h
    
    # Configure a server if not yet.
    /opt/perforce/sbin/configure-perforce-server.sh -n \
                                                    -p $P4PORT \
                                                    -u $P4USER \
                                                    -P $P4PASSWD $P4NAME
else
    # Start the server if yet.
    p4dctl start $P4NAME
fi

exec ls -1v --color=never /opt/perforce/servers/$P4NAME/logs/log | xargs tail -f
