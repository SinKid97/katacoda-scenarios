# Create Docker Secrets
We can put the sensitive information into a secret file and encrypt the data. So, the data can be saved securely instead of saving in the yml file.
## Close the previous docker
press ctrl + c
# Add secret part
First, add a secret part after the services part in yml file:

`docker-compose.yml` :
<pre>
secrets:
  mysql_root_password:
    file: ./secrets/mysql_root_password
  mysql_database:
    file: ./secrets/mysql_database
  mysql_user:
    file: ./secrets/mysql_user
  mysql_password:
    file: ./secrets/mysql_password

</pre>

## Add  individual secret files
`mysql_root_password`:
<pre class="file" data-target="clipboard">
mypassword
</pre>

`mysql_database`:
<pre class="file" data-target="clipboard">
wordpress
</pre>

`mysql_user`:
<pre class="file" data-target="clipboard">
wordpress
</pre>

`mysql_password`:
<pre class="file" data-target="clipboard">
wordpress
</pre>

## Compose the Docker with the yml, secret and envirnoment fils
The environment details should be modified like following:
<pre class="file" data-target="clipboard">
version: '3.6'

services:
  db:
    image: mysql:5.7
    volumes:
      - ./pipe:/var/log/mysql/
    restart: always
    command: mysqld --general_log=1 --log_output='FILE' --general-log-file=/var/log/mysql/general.log
    environment:
      MYSQL_ROOT_PASSWORD_FILE: /run/secrets/mysql_root_password
      MYSQL_DATABASE_FILE: /run/secrets/mysql_database
      MYSQL_USER_FILE: /run/secrets/mysql_user
      MYSQL_PASSWORD_FILE: /run/secrets/mysql_password
    networks:
      - elk
      
  wordpress:
    image: wordpress:latest
    depends_on:
      - db
    ports:
      - 8080:80
    restart: always
    environment:
      WORDPRESS_DB_HOST: db:3306
      WORDPRESS_DB_USER_FILE: /run/secrets/mysql_user
      WORDPRESS_DB_PASSWORD_FILE: /run/secrets/mysql_password
    # volumes:
      # - ./wordpress/data:/var/www/html/wp-content
    networks:
      - elk
      
networks:
  elk:
    driver: bridge

secrets:
  mysql_root_password:
    file: ./secrets/mysql_root_password
  mysql_database:
    file: ./secrets/mysql_database
  mysql_user:
    file: ./secrets/mysql_user
  mysql_password:
    file: ./secrets/mysql_password

</pre>

Use dcoker-compose up command to set up Docker

`docker-compose up`{{execute}}



