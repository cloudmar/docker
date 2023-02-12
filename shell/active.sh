# this docker code makes all your containers available after reboot

docker update --restart unless-stopped $(docker ps -q)
