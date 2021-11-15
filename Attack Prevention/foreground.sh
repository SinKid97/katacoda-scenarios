#/bin/bash
touch docker-compose.yml
mkdir cfg
cd cfg
touch setup.sql
cd ..
mkdir env_file
cd env_file
touch db.env
touch wp.env
cd ..
mkdir secrets
cd secrets
touch mysql_root_password
touch mysql_database
touch mysql_user
touch mysql_password
cd ..
