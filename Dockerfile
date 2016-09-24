FROM ubuntu:14.04

RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd

EXPOSE 22
EXPOSE 5000

#create user and .ssh config files
RUN useradd -m docker && \
    mkdir /home/docker/.ssh && \
    touch /home/docker/.ssh/authorized_keys

#change password to something random, we don't need it
RUN echo 'docker:'`openssl rand -base64 32` | chpasswd

#make sure the permissions are set correctly to make ssh happy
RUN sudo chown -R docker:docker /home/docker/.ssh && \
    sudo chmod 0700 /home/docker/.ssh && \
    sudo chmod 0600 /home/docker/.ssh/authorized_keys

#copy the public key and append it to the list of 
COPY id_rsa.pub .
RUN cat id_rsa.pub >> /home/docker/.ssh/authorized_keys && \
    rm id_rsa.pub

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd


CMD ["/usr/sbin/sshd", "-D"]
