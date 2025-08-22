FROM ubuntu

# Install OpenJDK 8, OpenSSH server, and Maven
RUN apt-get update -qy && \
    apt-get install openjdk-8-jdk -qy && \
    apt-get install openssh-server -qy && \
    apt-get install maven -qy

# Install Git and modify SSHD PAM configuration
RUN apt-get install git -qy && \
    sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd && \
    mkdir -p /var/run/sshd

# Create Jenkins user and set password
RUN useradd -ms /bin/bash jenkins --home /home/jenkins && \
    echo "jenkins:jenkins" | chpasswd

# Expose SSH port
EXPOSE 22

# Start SSH service
CMD ["/usr/sbin/sshd", "-D"]
