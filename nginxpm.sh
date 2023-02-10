# nginx proxy manager

echo "install nginx proxy manager setup"

sudo mkdir nginxpm && cd nginxpm

sudo mkdir /var/lib/mysql 

sudo cat > docker-compose.yml << EOF
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
      DB_MYSQL_USER: "Db@Mysql@User23"
      DB_MYSQL_PASSWORD: "Db@Mysql@Password23"
      DB_MYSQL_NAME: "nginxpm"
    volumes:
      - ./data:/data
      - ./letsencrypt:/etc/letsencrypt
  db:
    image: 'jc21/mariadb-aria:latest'
    environment:
      MYSQL_ROOT_PASSWORD: 'Db@Mysql@Password23'
      MYSQL_DATABASE: 'nginxpm'
      MYSQL_USER: 'Db@Mysql@User23'
      MYSQL_PASSWORD: 'Db@Mysql@Password23'
    volumes:
      - ./data/mysql:/var/lib/mysql
EOF

sudo cd nginxpm

echo "run: nano docker-compose.yml file to change database user and password"

echo "run: sudo docker-compose up -d"

echo "default user is admin@example.com and password is changeme"





