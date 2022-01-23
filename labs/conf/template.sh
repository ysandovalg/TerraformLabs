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

echo "*** FIN ***" >> /home/${username}/ilog
date '+%Y/%m/%d %H:%M:%S %z' >> /home/${username}/ilog


