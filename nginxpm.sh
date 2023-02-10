#!/bin/bash
# nginx proxy manager

echo "cloudmar 1.0"

echo "nginx proxy manager install setup"

sudo mkdir nginxpm && cd nginxpm
sudo mkdir mysql 

dbname=""
user=""
password=""

while [[ ("$dbname" == "")]];
do read -p "Enter your database name for nginx proxy manager: " dbname
done

while [[ ("$user" == "")]];
do read -p "Enter your database username for nginx proxy manager: " user
done

while [[ ("$password" == "")]];
do read -p "Enter your database password for nginx proxy manager: " password
done

sudo cat > docker-compose.yml << EOF
#default user is admin@example.com and password is changeme
version: '3'
services:
  app:
    image: 'jc21/nginx-proxy-manager:latest'
    ports:
      - '80:80'
      - '81:81'
      - '443:443'
    environment:
      DB_MYSQL_HOST: "db"
      DB_MYSQL_PORT: 3306
      DB_MYSQL_USER: "$user"
      DB_MYSQL_PASSWORD: "$password"
      DB_MYSQL_NAME: "$dbname"
    volumes:
      - ./data:/data
      - ./letsencrypt:/etc/letsencrypt
  db:
    image: 'jc21/mariadb-aria:latest'
    environment:
      MYSQL_ROOT_PASSWORD: '$password'
      MYSQL_DATABASE: '$dbname'
      MYSQL_USER: '$user'
      MYSQL_PASSWORD: '$password'
    volumes:
      - ./data/mysql: /var/lib/mysql
EOF

sudo docker-compose up -d

echo "go to EXTERNALIP:81 to login"
echo "default user is admin@example.com and password is changeme"
echo "enjoy ;)"







