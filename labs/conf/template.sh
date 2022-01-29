#!/bin/bash -x
date '+%Y/%m/%d %H:%M:%S %z' > /home/${username}/ilog
echo "Instaling Terraform..." >> /home/${username}/ilog

sudo apt update
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install terraform
terraform -install-autocomplete
echo "Terraform ok!" >> /home/${username}/ilog


# github labs
echo "Cloning Github project..." >> /home/${username}/ilog
runuser -l ${username} -c  'git clone https://github.com/cachac/TerraformLabs.git'
echo "Project ok!" >> /home/${username}/ilog

# docker
echo "Instaling Docker..." >> /home/${username}/ilog
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker ${username}
echo "Docker ok!" >> /home/${username}/ilog

# newgrp docker

# docker-compose
echo "Instaling Docker Compose..." >> /home/${username}/ilog
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
echo "Docker Compose ok!" >> /home/${username}/ilog


#code-server
echo "Starting Code-Server..." >> /home/${username}/ilog
mkdir -p /home/${username}/code-server
docker-compose up
echo "Code-Server ok!" >> /home/${username}/ilog

echo "*** FIN ***" >> /home/${username}/ilog
date '+%Y/%m/%d %H:%M:%S %z' >> /home/${username}/ilog
