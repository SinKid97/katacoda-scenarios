# Securing Passwords with Docker Secrets
In the Docker Compose file, the sensitive information can be read in plain text by anyone, such as user name, password and database name.
<br>
To secure the password, we cannot place the information in a file that everyone can access. We need to use Docker Secrets to separate the sensitive information. It can reduce the chance of expose the information.

## Close the previous docker
press ctrl + c
## docker-compose.yml file for Wordpress
We can see the sensitive information in the file without using Docker Secrets:

`docker-compose.yml` :
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

## Add sensitive information to environment files
Copy the sensitive information of mysql-server to "db.env":

`db.env`:
<pre class="file" data-target="clipboard">
MYSQL_ROOT_PASSWORD=mypassword
MYSQL_DATABASE=wordpress
MYSQL_USER=wordpress
MYSQL_PASSWORD=wordpress
</pre>

Copy the sensitive information of wordpress to "wp.env" file:

`wp.env`:
<pre class="file" data-target="clipboard">
WORDPRESS_DB_HOST=db:3306
WORDPRESS_DB_USER=wordpress
WORDPRESS_DB_PASSWORD=wordpress
</pre>

## Information in two environment files
`db.env`:
<pre>
 "Env": [
                "MYSQL_ROOT_PASSWORD=mypassword",
                "MYSQL_DATABASE=wordpress",
                "MYSQL_USER=wordpress",
                "MYSQL_PASSWORD=wordpress",
		...
</pre>

`wp.env`:
<pre>
 "Env": [
                "WORDPRESS_DB_HOST=db:3306",
                "WORDPRESS_DB_USER=wordpress",
                "WORDPRESS_DB_PASSWORD=wordpress",
		...
</pre>

## Compose the Docker with the yml and environment files
`docker-compose.yml` :
<pre class="file" data-target="clipboard">
version: '3.6'

services:
  db:
    image: mysql:5.7
    volumes:
      - ./pipe:/var/log/mysql/
    restart: always
    command: mysqld --general_log=1 --log_output='FILE' --general-log-file=/var/log/mysql/general.log
    env_file: ./env_file/db.env
    networks:
      - elk
      
  wordpress:
    image: wordpress:latest
    depends_on:
      - db
    ports:
      - 8080:80
    restart: always
    env_file: ./env_file/wp.env
    # volumes:
      # - ./wordpress/data:/var/www/html/wp-content
    networks:
      - elk
      
networks:
  elk:
    driver: bridge
</pre>

Use dcoker-compose up command to set up Docker

`docker-compose up`{{execute}}