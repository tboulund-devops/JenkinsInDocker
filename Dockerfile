FROM jenkins/jenkins

USER root

# Write RUN-statements here, that will install the required software within the Jenkins container

# Install SSDT
COPY ssdt /opt/ssdt

# Install dotnet
RUN wget https://packages.microsoft.com/config/debian/10/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
RUN dpkg -i packages-microsoft-prod.deb
RUN apt-get update; \
  apt-get install -y apt-transport-https && \
  apt-get update && \
  apt-get install -y dotnet-sdk-5.0

# Install Node
RUN curl -fsSL https://deb.nodesource.com/setup_15.x | bash -
RUN apt-get install -y nodejs

# Install Angular
RUN npm install -g @angular/cli

# Install sqlpackage
RUN apt-get install libunwind8
RUN wget -O sqlpackage.zip https://go.microsoft.com/fwlink/?linkid=2157202
RUN unzip sqlpackage.zip -d /opt/sqlpackage
RUN chmod a+x /opt/sqlpackage/sqlpackage
ENV PATH="/opt/sqlpackage:${PATH}"

# Install Docker
RUN apt-get update && apt-get install -y apt-transport-https \
       ca-certificates curl gnupg2 \
       software-properties-common
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN apt-key fingerprint 0EBFCD88
RUN add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/debian \
       $(lsb_release -cs) stable"
RUN apt-get update && apt-get install -y docker-ce-cli
RUN groupadd docker
RUN usermod -aG docker jenkins

# The file must end with this statement to make sure that Jenkins runs with the right user permission.
USER jenkins