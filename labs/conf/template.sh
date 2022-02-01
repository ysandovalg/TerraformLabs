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

# Nginx
echo "Installing Nginx..." >> /home/${username}/ilog
sudo apt install -y nginx certbot python3-certbot-nginx

sudo sed -i "s/username/${labuser}/g" /home/${username}/code-server.conf
sudo sed -i "s/username/${labuser}/g" /home/${username}/webserver.conf

sudo mv /home/${username}/code-server.conf /etc/nginx/sites-available/code-server.conf
sudo mv /home/${username}/webserver.conf /etc/nginx/sites-available/webserver.conf

sudo ln -s /etc/nginx/sites-available/code-server.conf /etc/nginx/sites-enabled/code-server.conf
sudo ln -s /etc/nginx/sites-available/webserver.conf /etc/nginx/sites-enabled/webserver.conf

sudo rm -f /etc/nginx/sites-available/default
sudo rm -f /etc/nginx/sites-enabled/default

sudo nginx -s reload

echo "Nginx Ok!" >> /home/${username}/ilog

#code-server
# https://coder.com/docs/code-server/latest/install#installsh
echo "Starting Code-Server..." >> /home/${username}/ilog
runuser -l ${username} -c 'curl -fsSL https://code-server.dev/install.sh -o /home/${username}/install.sh'
runuser -l ${username} -c 'sh /home/${username}/install.sh'

runuser -l ${username} -c 'sudo systemctl enable --now code-server@$USER'
sleep 10 | echo Code-Server Online! >> /home/${username}/ilog

# password
sudo sed -i "s/codepass/${codepass}/g" /home/${username}/config.yaml
sudo mv /home/${username}/config.yaml /home/${username}/.config/code-server/config.yaml >> /home/${username}/ilog
runuser -l ${username} -c 'sudo systemctl restart code-server@$USER' >> /home/${username}/ilog

echo "Code-Server ok!" >> /home/${username}/ilog

# certbot
i="0"
while [ $i -lt 10 ]
do
  if ! ping -c 1 code.${labuser}.terralabs.tk &> /dev/null
	then
		echo "waiting DNS records [$i]..." >> /home/${username}/ilog
		sleep 10
	else
		echo "code.${labuser}.terralabs.tk is online!!" >> /home/${username}/ilog
		break
	fi
	i=$[$i+1]
done
sleep 10 | echo "Issuing Certs..." >> /home/${username}/ilog
sudo certbot --non-interactive --redirect --agree-tos --nginx -d code.${labuser}.terralabs.tk -d ${labuser}.terralabs.tk -m info@storylabs.dev >> /home/${username}/ilog
echo "Certbot Online!" >> /home/${username}/ilog

# keybase
# curl --remote-name https://prerelease.keybase.io/keybase_amd64.deb
# sudo apt install ./keybase_amd64.deb
# keybase login  --devicename code.${labuser}.terralabs.tk
curl https://keybase.io/carlosechc11/pgp_keys.asc | gpg --import



echo "*** FIN ***" >> /home/${username}/ilog
date '+%Y/%m/%d %H:%M:%S %z' >> /home/${username}/ilog
