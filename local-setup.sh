# Install java
apt-get update
apt-get install -y default-jdk

# Install Jenkins
wget –q –O – https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add –
sh –c ‘echo deb https://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list’
apt-get update
apt-get install -y jenkins
systemctl start jenkins
systemctl enable jenkins

# Install dotnet 5
wget https://packages.microsoft.com/config/debian/10/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
dpkg -i packages-microsoft-prod.deb
apt-get update
apt-get install -y apt-transport-https
apt-get update
apt-get install -y dotnet-sdk-5.0

# Install Node
curl -fsSL https://deb.nodesource.com/setup_15.x | bash -
apt-get install -y nodejs

# Install Angular
RUN npm install -g @angular/cli

# Install sqlpackage
apt-get install libunwind8
wget -O sqlpackage.zip https://go.microsoft.com/fwlink/?linkid=2157202
unzip sqlpackage.zip -d /opt/sqlpackage
chmod a+x /opt/sqlpackage/sqlpackage
export PATH=$PATH:/opt/sqlpackage

# Install SSDT
cp ssdt /opt/ssdt

# Install Docker
apt-get update && apt-get install -y apt-transport-https \
       ca-certificates curl gnupg2 \
       software-properties-common
curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
apt-key fingerprint 0EBFCD88
add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/debian \
       $(lsb_release -cs) stable"
apt-get update && apt-get install -y docker-ce-cli
groupadd docker
usermod -aG docker jenkins

# Install Docker Compose
curl -L https://github.com/docker/compose/releases/download/1.29.1/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose