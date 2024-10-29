FROM rockylinux/rockylinux:latest

LABEL maintainer="Tonet Jallo <tonet@tuisp.pe>"

# Instala dependencias y nPerf
RUN dnf -y install yum-utils wget
RUN rpm --import https://repo.nperf.com/conf/nperf-server.gpg.sha256.key
RUN wget https://repo.nperf.com/rhel/nperf-server.repo -O /etc/yum.repos.d/nperf-server.repo
RUN dnf -y update
RUN dnf -y install nperf-server --nogpgcheck
RUN dnf clean all
RUN head /usr/local/bin/nPerfServer
RUN touch /var/lib/nperf-server/nPerfServer.uuid
RUN touch /var/lib/nperf-server/nPerfServer.pid
# Define el comando por defecto a ejecutar cuando el contenedor se inicie
CMD ["/usr/local/bin/nPerfServer", "--pidfile=/var/lib/nperf-server/nPerfServer.pid", "-p", "8080", "-t", "8443", "--uuidfile=/var/lib/nperf-server/nPerfServer.uuid"]
