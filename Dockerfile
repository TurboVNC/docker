FROM centos:5

RUN yum -y update \
 && yum -y install epel-release.noarch \
 && yum -y install \
    cmake28.x86_64 \
    dpkg.x86_64 \
    expect.x86_64 \
    gcc.x86_64 \
    gnupg.x86_64 \
    glibc-devel \
    git.x86_64 \
    java-1.7.0-openjdk-devel.x86_64 \
    libgcc.i386 \
    libX11-devel \
    libXext-devel \
    libXi-devel \
    libXt-devel \
    make.x86_64 \
    openssl-devel \
    pam-devel \
    redhat-rpm-config \
    rpm-build.x86_64 \
    wget.x86_64 \
 && ln -fs /usr/bin/ccmake28 /usr/bin/ccmake \
 && ln -fs /usr/bin/cmake28 /usr/bin/cmake \
 && ln -fs /usr/bin/cpack28 /usr/bin/cpack \
 && ln -fs /usr/bin/ctest28 /usr/bin/ctest \
 && wget --no-check-certificate https://sourceforge.net/projects/libjpeg-turbo/files/1.5.1/libjpeg-turbo-official-1.5.1.x86_64.rpm \
 && wget --no-check-certificate https://sourceforge.net/projects/libjpeg-turbo/files/1.5.1/libjpeg-turbo-official-1.5.1.i386.rpm \
 && rpm -i *.rpm \
 && rm *.rpm \
 && wget --no-check-certificate https://sourceforge.net/projects/libjpeg-turbo/files/1.5.1/libjpeg-turbo-1.5.1-jws.zip \
 && unzip -d /opt/libjpeg-turbo-jni *.zip \
 && rm *.zip \
 && git clone --depth=1 https://gitlab.com/debsigs/debsigs.git -b debsigs-0.1.15%7Eroam1 ~/src/debsigs \
 && pushd ~/src/debsigs \
 && perl Makefile.PL \
 && make install \
 && popd \
 && rm -rf ~/src \
 && cd / \
 && yum clean all \
 && find /usr/lib/locale/ -mindepth 1 -maxdepth 1 -type d -not -path '*en_US*' -exec rm -rf {} \; \
 && find /usr/share/locale/ -mindepth 1 -maxdepth 1 -type d -not -path '*en_US*' -exec rm -rf {} \; \
 && localedef --list-archive | grep -v -i ^en | xargs localedef --delete-from-archive \
 && mv /usr/lib/locale/locale-archive /usr/lib/locale/locale-archive.tmpl \
 && /usr/sbin/build-locale-archive \
 && echo "" >/usr/lib/locale/locale-archive.tmpl \
 && find /usr/share/{man,doc,info} -type f -delete \
 && rm -rf /etc/ld.so.cache \ && rm -rf /var/cache/ldconfig/* \
 && rm -rf /tmp/*

# Set default command
CMD ["/bin/bash"]
