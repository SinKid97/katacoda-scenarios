#Securing Passwords with Docker Secrets
In the Docker Compose file, the sensitive information can be read in plain text by anyone, such as user name, password and database name.
<br>
To secure the password, we cannot place the information in a file that everyone can access. We need to use Docker Secrets to separate the sensitive information. It can reduce the chance of expose the information.

##Close the previous docker
press ctrl + c
## docker-compose.yml file for Wordpress
We can see the sensitive information in the file without using Docker Secrets:

`docker-compose.yml` :
<pre class="file" data-target="clipboard">
version: '3.2' 
 
services: 
    mysql-server: 
        container_name: mysql 
        ports: 
            - "13306:3306"    
        volumes:  
            - ./cfg/setup.sql:/docker-entrypoint-initdb.d/setup.sql
        command: mysqld --general_log=1 --log_output='table'
        environment: 
            MYSQL_ROOT_PASSWORD: 12345 
            MYSQL_DATABASE: wordpress 
            MYSQL_USER: wordpress_user 
            MYSQL_PASSWORD: secret 
        image: mysql:5.7 
    
    wordpress: 
        image: wordpress:latest 
        container_name: wordpress 
        ports: 
            - "20080:80" 
        environment: 
            WORDPRESS_DB_HOST: mysql-server:3306 
            WORDPRESS_DB_USER: wordpress_user 
            WORDPRESS_DB_PASSWORD: secret 
        depends_on: 
            - mysql-server 

</pre>

## Add sensitive information to environment files
Copy the sensitive information of mysql-server to "db.env":

`db.env`:
<pre class="file" data-target="clipboard">
MYSQL_ROOT_PASSWORD=12345
MYSQL_DATABASE=wordpress
MYSQL_USER=wordpress_user
MYSQL_PASSWORD=secret
</pre>

Copy the sensitive information of wordpress to "wp.env" file:

`wp.env`:
<pre class="file" data-target="clipboard">
WORDPRESS_DB_HOST=mysql-server:3306
WORDPRESS_DB_USER=wordpress_user
WORDPRESS_DB_PASSWORD=secret
</pre>

## Information in two environment files
`db.env`:
<pre>
 "Env": [
                "MYSQL_ROOT_PASSWORD=12345",
                "MYSQL_DATABASE=wordpress",
                "MYSQL_USER=wordpress_user",
                "MYSQL_PASSWORD=secret",
		...
</pre>

`wp.env`:
<pre>
 "Env": [
                "WORDPRESS_DB_HOST=mysql-server:3306",
                "WORDPRESS_DB_USER=wordpress_user",
                "WORDPRESS_DB_PASSWORD=secret",
		...
</pre>

## Compose the Docker with the yml and environment files
`docker-compose.yml` :
<pre class="file" data-target="clipboard">
version: '3.2' 
 
services: 
    mysql-server: 
        container_name: mysql 
        ports: 
            - "13306:3306"    
        volumes:  
            - ./cfg/setup.sql:/docker-entrypoint-initdb.d/setup.sql
        command: mysqld --general_log=1 --log_output='table'
        env_file:
             - ./db.env 
        image: mysql:5.7 
    
    wordpress: 
        image: wordpress:latest 
        container_name: wordpress 
        ports: 
            - "20080:80" 
        env_file:
             - ./wp.env 
        depends_on: 
            - mysql-server 

</pre>
Use dcoker-compose up command to set up Docker

`docker-compose up`{{execute}}