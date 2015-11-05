# This Dockerfile is used to build an image containing basic stuff to be used as a Jenkins slave build node,
# plus dependencies for our build and some tools we use for testing.
# Note the plaintext password here; depending on your environment that may not be advisable.
# Based on evarga/jenkins-slave
FROM    java:openjdk-7
MAINTAINER  Martijn Koster "martijn.koster@lucidworks.com"

ENV PHANTOMJS_VERSION=1.9.8

RUN export DEBIAN_FRONTEND=noninteractive TERM=linux && \
  echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections && \
  apt-get update && \
  apt-get -y install ant git openssh-server \
  build-essential libxml2-dev libxslt1-dev python-dev python-pip \
  libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev \
  curl netcat-openbsd net-tools procps lsof && \
  sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd && \
  mkdir -p /var/run/sshd && \
  adduser --quiet --gecos "" --disabled-password jenkins && \
  (echo "jenkins:jenkins" | chpasswd)  && \
  pip install virtualenv && \
  pip install awscli && \
  apt-get -y install vim
RUN export DEBIAN_FRONTEND=noninteractive TERM=linux && \
  apt-get -y install locales && \
  sed -i.bak -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
  locale-gen && \
  update-locale LC_ALL="en_US.UTF-8" && \
  export LANGUAGE=en_US:en && \
  export LANG=en_US.UTF-8 && \
  export LC_ALL=en_US.UTF-8 && \
  dpkg-reconfigure locales
RUN export DEBIAN_FRONTEND=noninteractive TERM=linux && \
  apt-get -y install ruby ruby-dev nodejs && \
  gem install asciidoctor jekyll jekyll-asciidoc

RUN export DEBIAN_FRONTEND=noninteractive TERM=linux && \
  pip install linkchecker

ENV LANGUAGE en_US:en
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

EXPOSE 22 8764

CMD ["/usr/sbin/sshd", "-D"]
