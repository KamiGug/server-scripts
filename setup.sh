sudo apt update && sudo apt -y upgrade;
sudo apt-get install ca-certificates curl;
sudo install -m 0755 -d /etc/apt/keyrings;
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc;
sudo chmod a+r /etc/apt/keyrings/docker.asc;
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null;
sudo apt-get update;
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-ce-rootless-extras;
sudo apt install uidmap;
sudo useradd dockerer;
echo 'dockerer:powerpasswd' | sudo chpasswd
sudo usermod -a -G docker dockerer;
sudo usermod -s /bin/bash dockerer;
sudo loginctl enable-linger dockerer;

sudo systemctl disable --now docker.service docker.socket
sudo systemctl stop --now docker.service docker.socket
sudo rm /var/run/docker.sock

sudo mkdir ~dockerer;
sudo mkdir ~dockerer/.ssh;
sudo cp ~/.ssh/authorized_keys ~dockerer/.ssh/authorized_keys;
sudo cp ~/.bashrc ~dockerer/;
sudo chown -R dockerer:dockerer ~dockerer;
#passwd #change password
#dockerer password
#powerpasswd

#add key to the ssh server with ssh-copy-id
#sudo nano /etc/ssh/sshd_config

#sshd config - no password allowed -> only key
su dockerer;
