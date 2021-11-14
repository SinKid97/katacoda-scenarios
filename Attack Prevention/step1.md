# Setup Docker

First, we need to create `docker-compose.yml` for docker setup.

`docker-compose.yml`:
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

With this docker compose file, there are 2 docker containers created.  

We can execute the following command to compose the docker file:

`docker-compose up`{{execute}}
