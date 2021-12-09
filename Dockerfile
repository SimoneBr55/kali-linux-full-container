FROM kalilinux/kali-rolling

LABEL maintainer="Booyaabes"

RUN apt-get -y update && apt-get -y upgrade && \
   DEBIAN_FRONTEND=noninteractive apt-get install -y \
   kali-linux-large \
   pciutils \
   nano \
   iputils-ping \
   steghide \
   basez \
   bash-completion && \
   apt-get autoremove -y && \
   apt-get clean

RUN printf "alias ll='ls $LS_OPTIONS -l'\nalias l='ls $LS_OPTIONS -lA'\n\n# enable bash completion in interactive shells\nif [ -f /etc/bash_completion ] && ! shopt -oq posix; then\n    . /etc/bash_completion\nfi\n" > /root/.bashrc
RUN mkdir /data
RUN sed -i "s|#Port 22|Port 313|g" /etc/ssh/sshd_config
RUN sed -i "s|#PermitRootLogin prohibit-password|PermitRootLogin yes|g" /etc/ssh/sshd_config
RUN echo "root:root" | chpasswd
RUN service ssh start
COPY software_temp.tar /tmp/
COPY opt.tar /opt/ 

CMD "/bin/bash"
