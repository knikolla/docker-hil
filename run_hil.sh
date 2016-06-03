#!/usr/bin/env bash

# Configure /etc/haas.cfg
if [ "$DB" == sqlite ]; then
    DATABASE_URI="sqlite:///haas.db"
elif [ "$DB" == postgresql ]; then
    :
fi

sed -e "
    s|%DATABASE_URI%|$DATABASE_URI|g;
" -i /etc/haas.cfg

haas-admin db create

# Run apache in the foreground
apachectl -DFOREGROUND