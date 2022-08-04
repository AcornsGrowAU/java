FROM registry.fedoraproject.org/fedora-minimal:35

SHELL ["/bin/bash", "-c"]

ARG JAVA_VERSION=11

RUN microdnf --nodocs -y upgrade && \
    microdnf --nodocs -y install \
    apache-commons-codec \
    gettext \
    java-${JAVA_VERSION}-openjdk-devel \
    postgresql \
    postgresql-jdbc \
    mariadb \
    snakeyaml \
    tar \
    tzdata \
    netcat \
    vim \
    wget && \
    microdnf --nodocs -y reinstall tzdata && \
    microdnf clean all

ONBUILD ARG UID=1000
ONBUILD RUN useradd -d /java -l -m -Uu ${UID} -r -s /bin/bash java && \
  chown -R ${UID}:${UID} /java