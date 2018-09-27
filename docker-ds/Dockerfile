FROM ubuntu:18.04

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install software-properties-common -y && \
    add-apt-repository ppa:webupd8team/java -y && \
    apt-get update && \
    echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
    apt-get install -y oracle-java8-installer && \
    apt-get clean
    
ARG JAVA_HOME=/usr/lib/jvm/java-8-oracle/jre
ENV JAVA_HOME=$JAVA_HOME

ARG MAVEN_VERSION=3.5.4
ARG BASE_URL=http://www-us.apache.org/dist/maven/maven-3/${MAVEN_VERSION}/binaries

RUN apt-get update -y && \
    cd /opt && \
    wget ${BASE_URL}/apache-maven-${MAVEN_VERSION}-bin.tar.gz && \
    tar -xf apache-maven-${MAVEN_VERSION}-bin.tar.gz && \
    mv apache-maven-${MAVEN_VERSION}/ apache-maven/ && \
    update-alternatives --install /usr/bin/mvn maven /opt/apache-maven/bin/mvn 1001 && \
    apt-get clean    

RUN apt-get install vim -y && \
    apt-get install git -y && \
    curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash && \
    apt-get install git-lfs -y && \
    locale-gen en_US en_US.UTF-8 && \
    update-locale LANG=en_US.UTF-8 && \
    echo 'export LANG=en_US.UTF-8\nexport LC_ALL=en_US.UTF-8' >> ~/.bashrc

WORKDIR /data

CMD tail -f /dev/null
