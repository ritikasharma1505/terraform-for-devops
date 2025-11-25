- Install Terraform on Ubuntu:

```
sudo apt update && sudo apt upgrade -y

sudo apt install -y gnupg software-properties-common curl

wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

sudo apt update && sudo apt install terraform -y
```
- Check Terraform Installed version:

```
terraform -v
```

- Install AWS CLI:

```
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

sudo apt install unzip -y
unzip awscliv2.zip

sudo ./aws/install
aws --version

```

**Terraform commands used:**

```
terraform fmt

terraform init    

terraform validate

terraform plan

terraform apply

terraform destroy

```