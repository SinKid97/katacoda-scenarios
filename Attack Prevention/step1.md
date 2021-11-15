# Setup Docker

First, we need to create `docker-compose.yml` for docker setup.

`docker-compose.yml`:
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
      MYSQL_ROOT_PASSWORD: mypassword
      MYSQL_DATABASE: wordpress
      MYSQL_USER: wordpress
      MYSQL_PASSWORD: wordpress
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
      WORDPRESS_DB_USER: wordpress
      WORDPRESS_DB_PASSWORD: wordpress
    # volumes:
      # - ./wordpress/data:/var/www/html/wp-content
    networks:
      - elk
      
networks:
  elk:
    driver: bridge
</pre>

With this docker compose file, there are 2 docker containers created.  

We can execute the following command to compose the docker file:

`docker-compose up`{{execute}}
