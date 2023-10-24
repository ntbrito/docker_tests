FROM amazonlinux:latest

# Install some extra packages
RUN yum update -y \
 && yum install -y \
    curl \
    jq \
    unzip \
    which \
    openssh \
    autoconf \
    libtool \
    python3 \
    python3-pip \
 && python3 -m pip install -U pip \
 && python3 -m pip install -U setuptools \
 && yum clean all

# Install ansible and boto3
RUN pip install ansible \
 && pip install boto3

# Install aws-cli, doing it according to AWS documentation
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
 && unzip awscliv2.zip \
 && ./aws/install

ENV JAVA_HOME /etc/alternatives/jre_openjdk

ARG user=nelson
ARG group=nelson
ARG uid=1000
ARG gid=1000
ARG http_port=8080

RUN groupadd -g ${gid} ${group} \
 && useradd -u ${uid} -g ${gid} -m -s /bin/bash ${user}

USER ${user}

## COPY tini-shim.sh /bin/tini
## ENTRYPOINT ["/sbin/tini", "--", "/usr/local/bin/jenkins.sh"]

CMD ["/bin/bash"]