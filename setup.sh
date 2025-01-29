dockeruser="dockerer"
password="powerpass"
while getopts u:p: flag
do
	case "${flag}" in
		u) dockeruser=${OPTARG};;
		p) password=${OPTARG};;
	esac
done

sudo apt update && sudo apt upgrade -y;
sudo apt-get install -y ca-certificates curl;
sudo install -m 0755 -d /etc/apt/keyrings;
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc;
sudo chmod a+r /etc/apt/keyrings/docker.asc;
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null;
sudo apt-get update;
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-ce-rootless-extras;
sudo apt install -y uidmap;
sudo useradd $dockeruser;
echo '$dockeruser:$password' | sudo chpasswd
sudo usermod -a -G docker $dockeruser;
sudo usermod -s /bin/bash $dockeruser;
sudo loginctl enable-linger $dockeruser;

sudo systemctl disable --now docker.service docker.socket
sudo systemctl stop --now docker.service docker.socket
sudo rm /var/run/docker.sock

sudo mkdir /home/$dockeruser;
sudo mkdir /home/$dockeruser/.ssh;
sudo cp ~/.ssh/authorized_keys /home/$dockeruser/.ssh/authorized_keys;
sudo cp ~/.bashrc /home/$dockeruser/;
sudo cp setup-dockerer.sh /home/$dockeruser/setup.sh
sudo chown -R $dockeruser:$dockeruser /home/$dockeruser;
#passwd #change password
#dockerer password
#powerpasswd

#add key to the ssh server with ssh-copy-id
#sudo nano /etc/ssh/sshd_config

#sshd config - no password allowed -> only key
echo "now ssh to the $dockeruser using the key used to ssh into $USER@$(hostname) and run the setup.sh";
#sudo su $dockeruser;
