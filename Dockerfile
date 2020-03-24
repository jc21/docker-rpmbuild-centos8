FROM jc21/rpmbuild-centos8:latest

MAINTAINER Jamie Curnow <jc@jc21.com>
LABEL maintainer="Jamie Curnow <jc@jc21.com>"

USER root

# Golang
RUN yum -y update \
  && yum -y install golang \
  && yum clean all \
  && rm -rf /var/cache/yum

# Update golang
RUN yum localinstall -y \
  https://yum.jc21.com/centos/base/el/8/x86_64/golang-1.14-1.el8.x86_64.rpm \
  https://yum.jc21.com/centos/base/el/8/x86_64/golang-bin-1.14-1.el8.x86_64.rpm \
  https://yum.jc21.com/centos/base/el/8/x86_64/golang-race-1.14-1.el8.x86_64.rpm \
  https://yum.jc21.com/centos/base/el/8/x86_64/golang-shared-1.14-1.el8.x86_64.rpm \
  https://yum.jc21.com/centos/base/el/8/noarch/golang-src-1.14-1.el8.noarch.rpm

USER rpmbuilder

