FROM centos:8

LABEL maintainer="Jamie Curnow <jc@jc21.com>"

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Yum
RUN yum -y install epel-release drpm dnf-plugins-core \
	&& dnf config-manager --set-enabled powertools \
	&& yum localinstall -y https://yum.jc21.com/jc21-yum.rpm \
	&& yum -y update \
	&& yum -y install scl-utils scl-utils-build which mock git wget curl kernel-devel rpmdevtools rpmlint rpm-build sudo gcc-c++ make automake autoconf yum-utils scl-utils scl-utils-build cmake libtool expect \
	&& yum -y install aspell-devel bzip2-devel chrpath cyrus-sasl-devel enchant-devel fastlz-devel fontconfig-devel freetype-devel gettext-devel gmp-devel \
	httpd-devel krb5-devel libacl-devel libcurl-devel libdb-devel libedit-devel liberation-sans-fonts libevent-devel libgit2 libicu-devel libjpeg-turbo-devel libuuid-devel \
	libmcrypt-devel libmemcached-devel libpng-devel libtiff-devel libtool-ltdl-devel libwebp-devel libX11-devel libXpm-devel libxml2-devel \
	libxslt-devel memcached net-snmp-devel openldap-devel openssl-devel pam-devel pcre-devel perl-generators postgresql-devel recode-devel sqlite-devel \
	systemd-devel systemtap-sdt-devel tokyocabinet-devel unixODBC-devel zlib-devel \
	&& yum clean all \
	&& rm -rf /var/cache/yum

# build files
COPY bin/build-spec /bin/
COPY bin/build-all /bin/

# Sudo
COPY etc/sudoers.d/wheel /etc/sudoers.d/
RUN chown root:root /etc/sudoers.d/*

# Remove requiretty from sudoers main file
RUN sed -i '/Defaults    requiretty/c\#Defaults    requiretty' /etc/sudoers
RUN sed -i '/Defaults.*XAUTHORITY"/a Defaults    env_keep += "HTTP_PROXY HTTPS_PROXY NO_PROXY http_proxy https_proxy no_proxy"' /etc/sudoers

# Rpm User
RUN adduser -G wheel rpmbuilder \
	&& mkdir -p /home/rpmbuilder/rpmbuild/{BUILD,SPECS,SOURCES,BUILDROOT,RPMS,SRPMS,tmp} \
	&& chmod -R 777 /home/rpmbuilder/rpmbuild

COPY .rpmmacros /home/rpmbuilder/
USER rpmbuilder

WORKDIR /home/rpmbuilder
