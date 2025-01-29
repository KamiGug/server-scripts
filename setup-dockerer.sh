/usr/bin/dockerd-rootless-setuptool.sh install
echo export DOCKER_HOST=unix:///run/user/$UID/docker.sock >> ~/.bashrc
systemctl --user status docker
