# wordpress install

mkdir wordpress && cd wordpress 

cat > docker-compose.yml << EOF
version: '3.7'
 
networks:
  mynet:
 
volumes:
  db_data: {}
 
services:
 
  db:
    image: mysql:5.7
    volumes:
      - db_data:/var/lib/mysql
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: password
      MYSQL_DATABASE: wordpress
      MYSQL_USER: wordpress
      MYSQL_PASSWORD: wordpress
    networks:
      - mynet
 
  phpmyadmin:
    image: phpmyadmin/phpmyadmin
    ports:
      - "8181:80"
    environment:
      PMA_HOST: db
    networks:
      - mynet
    depends_on:
      - db
 
  wordpress:
    image: wordpress:latest
    volumes:
      - ./docker/php.ini:/usr/local/etc/php/conf.d/wp-php.ini
      - ./wordpress:/var/www/html
    ports:
      - "8080:80"
    restart: always
    environment:
      WORDPRESS_DB_HOST: db:3306
      WORDPRESS_DB_USER: wordpress
      WORDPRESS_DB_PASSWORD: wordpress
      WORDPRESS_DB_NAME: wordpress
    networks:
      - mynet
    depends_on:
      - db

EOF

docker-compose up -d
