docker exec --user=root kanban /bin/sh -c 'chown -R www-data:www-data /var/www/html/public/userfiles'
docker exec --user=root kanban /bin/sh -c 'chown -R www-data:www-data /var/www/html/userfiles'
docker exec --user=root kanban /bin/sh -c 'chown -R www-data:www-data /var/www/html/app/Plugins'
docker exec --user=root kanban /bin/sh -c 'chown -R www-data:www-data /var/www/html/storage/logs'
