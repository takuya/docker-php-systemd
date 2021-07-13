# docker-php-systemd
docker container with systemd for LAMP


## LAMP 

To run old php WebApp

## run 

```shell
IMAGE=takuya/ubuntu-systemd-1804-modphp
mkdir data
data_dir=$(pwd)/data 
PORT_PUBLISH=33400
NAME=myapp

docker run \
   --name ${NAME}
   -d \
   --rm \
   --privileged \
   -v ${data_dir}/mysql:/var/lib/mysql \
   -v ${data_dir}/web:/var/www/html \
   -p ${PORT_PUBLISH}:80 \
  ${IMAGE}
```

## after startup 

you must re-initialize mysql 


` mysqld --initialized ` will be needed, when specify volume ` -v vol:/var/lib/mysql `.

```shell
NAME=myapp
docker exec -it $(docker ps -q --filter name=$NAME)  mysqld --initialize
docker exec -it $(docker ps -q --filter name=$NAME)  cat /var/log/mysql/error.log  | grep -i pass
docker exec -it $(docker ps -q --filter name=$NAME)  mysql -p 
```
```sql
ALTER USER 'root'@'localhost' IDENTIFIED  BY 'MYSQL_ROOT_PASSWORD';
```

## test php is running 


```shell
docker exec -it $(docker ps -q --filter name=$NAME)  chown www-data  -R /var/www/html
docker exec -it $(docker ps -q --filter name=$NAME)  echo "<?php phpinfo();" >> /var/www/html/phpinfo.php
curl localhost:${PORT_PUBLISH}/phpinfo.php
```
