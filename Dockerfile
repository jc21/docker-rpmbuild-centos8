FROM jc21/rpmbuild-centos8:latest

MAINTAINER Jamie Curnow <jc@jc21.com>
LABEL maintainer="Jamie Curnow <jc@jc21.com>"

USER root

# Golang
RUN yum -y update \
  && yum -y install golang \
  && yum clean all \
  && rm -rf /var/cache/yum

USER rpmbuilder

