#!/usr/bin/env bash

# Configure /etc/haas.cfg
if [ "$DB" == sqlite ]; then
    mkdir /sqlite
    DATABASE_URI="sqlite:////sqlite/haas.db"
elif [ "$DB" == postgresql ]; then
    :
fi

sed -e "
    s|%DATABASE_URI%|$DATABASE_URI|g;
" -i /etc/haas.cfg

cd /etc && haas-admin db create

if [ "$DB" == sqlite ]; then
    # Since haas-admin db create will be run from the root user
    # www-data will not have access to the sqlite file.
    chown -R www-data:www-data /sqlite
fi

# Run apache in the foreground
apachectl -DFOREGROUND