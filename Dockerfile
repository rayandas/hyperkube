FROM gcr.io/google_containers/hyperkube:v1.16.12
RUN sed -i -e 's!\bmain\b!main contrib!g' /etc/apt/sources.list && \
    apt-get update && apt-get upgrade -y && apt-get clean && \
    clean-install apt-transport-https gnupg1 curl zfsutils-linux \
    && echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ buster main" > \
    /etc/apt/sources.list.d/azure-cli.list \
    && curl -L https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && apt-get purge gnupg \
    && clean-install \
    xfsprogs \
    open-iscsi \
    azure-cli \
    iproute2 \
    iputils-ping \
    procps \
    glusterfs-client \
    glusterfs-common \
    samba-common \
    arptables

RUN update-alternatives --set iptables /usr/sbin/iptables-legacy && \
    update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy && \
    update-alternatives --set arptables /usr/sbin/arptables-legacy && \
    update-alternatives --set ebtables /usr/sbin/ebtables-legacy
