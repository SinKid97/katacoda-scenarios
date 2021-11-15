#Create Docker Secrets
We can put the sensitive information into a secret file and encrypt the data. So, the data can be saved securely instead of saving in the yml file.

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

##Add  individual secret files
`mysql_root_password`:
<pre class="file" data-target="clipboard">
12345
</pre>

`mysql_database`:
<pre class="file" data-target="clipboard">
wordpress
</pre>

`mysql_user`:
<pre class="file" data-target="clipboard">
wordpress_user
</pre>

`mysql_password`:
<pre class="file" data-target="clipboard">
secret
</pre>

##Compose the Docker with the yml, secret and envirnoment fils
The environment details should be modified like following:
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
        secrets:
            - mysql_root_password
            - mysql_database
            - mysql_user
            - mysql_password
        environment: 
            MYSQL_ROOT_PASSWORD_FILE: /run/secrets/mysql_root_password 
            MYSQL_DATABASE_FILE: /run/secrets/mysql_database 
            MYSQL_USER_FILE: /run/secrets/mysql_user
            MYSQL_PASSWORD_FILE: /run/secrets/mysql_password
        image: mysql:5.7 
    
    wordpress: 
        image: wordpress:latest 
        container_name: wordpress 
        ports: 
            - "20080:80" 
        secrets:
            - mysql_user
            - mysql_password
        environment:
            WORDPRESS_DB_USER_FILE: /run/secrets/mysql_user 
            WORDPRESS_DB_PASSWORD_FILE: /run/secrets/mysql_password 
        depends_on: 
            - mysql-server 

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



