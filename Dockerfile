FROM centos:5

RUN cat /etc/yum.repos.d/CentOS-Base.repo | sed s/^mirrorlist=/#mirrorlist=/g | sed 's@^#baseurl=http://mirror\.centos\.org/centos/\$releasever@baseurl=http://vault.centos.org/5.11@g' >/etc/yum.repos.d/CentOS-Base.repo.new \
 && mv -f /etc/yum.repos.d/CentOS-Base.repo.new /etc/yum.repos.d/CentOS-Base.repo \
 && cat /etc/yum.repos.d/libselinux.repo | sed s/^mirrorlist=/#mirrorlist=/g | sed 's@^#baseurl=http://mirror\.centos\.org/centos/\$releasever@baseurl=http://vault.centos.org/5.11@g' >/etc/yum.repos.d/libselinux.repo.new \
 && mv -f /etc/yum.repos.d/libselinux.repo.new /etc/yum.repos.d/libselinux.repo \
 && yum -y update \
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
    zip.x86_64 \
 && ln -fs /usr/bin/ccmake28 /usr/bin/ccmake \
 && ln -fs /usr/bin/cmake28 /usr/bin/cmake \
 && ln -fs /usr/bin/cpack28 /usr/bin/cpack \
 && ln -fs /usr/bin/ctest28 /usr/bin/ctest \
 && mkdir ~/src \
 && pushd ~/src \
 && wget http://www.openssl.org/source/openssl-1.0.2n.tar.gz \
 && tar xfz openssl-1.0.2n.tar.gz \
 && pushd openssl-1.0.2n \
 && ./config --prefix=/opt/openssl shared \
 && make install \
 && popd \
 && popd \
 && mv /opt/openssl/lib/libssl.so.1.0.0 /opt/openssl/lib/libssl.so.6 \
 && mv /opt/openssl/lib/libcrypto.so.1.0.0 /opt/openssl/lib/libcrypto.so.6 \
 && ln -fs libssl.so.6 /opt/openssl/lib/libssl.so \
 && ln -fs libcrypto.so.6 /opt/openssl/lib/libcrypto.so \
 && export LD_LIBRARY_PATH=/opt/openssl/lib:$LD_LIBRARY_PATH \
 && git clone --depth=1 https://gitlab.com/debsigs/debsigs.git -b debsigs-0.1.15%7Eroam1 ~/src/debsigs \
 && pushd ~/src/debsigs \
 && perl Makefile.PL \
 && make install \
 && popd \
 && rm -rf ~/src \
 && mkdir /usr/java \
 && curl -L -H "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u171-b11/512cd62ec5174c3487ac17c61aaa89e8/jdk-8u171-linux-i586.tar.gz | tar -C /usr/java/ -xz \
 && mv /usr/java/jdk1.8.0_171 /usr/java/default32 \
 && rm -rf /usr/java/default32/*src.zip \
           /usr/java/default32/lib/missioncontrol \
           /usr/java/default32/lib/visualvm \
           /usr/java/default32/lib/*javafx* \
           /usr/java/default32/jre/lib/plugin.jar \
           /usr/java/default32/jre/bin/javaws \
           /usr/java/default32/jre/lib/javaws.jar \
           /usr/java/default32/jre/lib/desktop/* \
           /usr/java/default32/jre/plugin/* \
           /usr/java/default32/jre/lib/deploy* \
           /usr/java/default32/jre/lib/*javafx* \
           /usr/java/default32/jre/lib/*jfx* \
           /usr/java/default32/jre/lib/ext/* \
           /usr/java/default32/jre/lib/jfr* \
           /usr/java/default32/jre/lib/oblique-fonts/* \
           /usr/java/default32/jre/lib/i386/libdecora_sse.so \
           /usr/java/default32/jre/lib/i386/libprism_*.so \
           /usr/java/default32/jre/lib/i386/libfxplugins.so \
           /usr/java/default32/jre/lib/i386/libglass.so \
           /usr/java/default32/jre/lib/i386/libgstreamer-lite.so \
           /usr/java/default32/jre/lib/i386/libjavafx*.so \
           /usr/java/default32/jre/lib/i386/libjfx*.so \
           *.tar.gz \
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

# Set environment
ENV PATH /opt/openssl/bin:${PATH}
ENV LD_LIBRARY_PATH /opt/openssl/lib:${LD_LIBRARY_PATH}

# Set default command
CMD ["/bin/bash"]
