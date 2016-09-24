FROM resin/rpi-raspbian:jessie

RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd

#create user and .ssh config files
RUN mkdir /root/.ssh && \
    touch /root/.ssh/authorized_keys

#change password to something random, we don't need it
RUN echo 'root:'`openssl rand -base64 32` | chpasswd

#copy the public key and append it to the list of 
COPY id_rsa.pub .
RUN cat id_rsa.pub >> /root/.ssh/authorized_keys && \
    rm id_rsa.pub

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

EXPOSE 22
EXPOSE 5000

CMD ["/usr/sbin/sshd", "-D"]
