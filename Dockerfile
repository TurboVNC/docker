FROM centos:7

RUN cat /etc/yum.repos.d/CentOS-Base.repo | sed s/^mirrorlist=/#mirrorlist=/g | sed 's@^#baseurl=http://mirror\.centos\.org/@baseurl=https://vault\.centos\.org/@g' >/etc/yum.repos.d/CentOS-Base.repo.new \
 && mv -f /etc/yum.repos.d/CentOS-Base.repo.new /etc/yum.repos.d/CentOS-Base.repo \
 && cat /etc/yum.repos.d/CentOS-fasttrack.repo | sed s/^mirrorlist=/#mirrorlist=/g | sed 's@^#baseurl=http://mirror\.centos\.org/@baseurl=https://vault\.centos\.org/@g' >/etc/yum.repos.d/CentOS-fasttrack.repo.new \
 && mv -f /etc/yum.repos.d/CentOS-fasttrack.repo.new /etc/yum.repos.d/CentOS-fasttrack.repo \
 && yum -y install centos-release-scl \
 && cat /etc/yum.repos.d/CentOS-SCLo-scl.repo | sed s/^mirrorlist=/#mirrorlist=/g | sed 's@^# baseurl=http://mirror\.centos\.org/@baseurl=https://vault\.centos\.org/@g' >/etc/yum.repos.d/CentOS-SCLo-scl.repo.new \
 && mv -f /etc/yum.repos.d/CentOS-SCLo-scl.repo.new /etc/yum.repos.d/CentOS-SCLo-scl.repo \
 && cat /etc/yum.repos.d/CentOS-SCLo-scl-rh.repo | sed s/^mirrorlist=/#mirrorlist=/g | sed 's@^#baseurl=http://mirror\.centos\.org/@baseurl=https://vault\.centos\.org/@g' >/etc/yum.repos.d/CentOS-SCLo-scl-rh.repo.new \
 && mv -f /etc/yum.repos.d/CentOS-SCLo-scl-rh.repo.new /etc/yum.repos.d/CentOS-SCLo-scl-rh.repo
RUN yum -y update \
 && yum -y install epel-release.noarch \
 && yum -y install \
    audit-libs-devel \
    automake \
    binutils-devel \
    bzip2-devel \
    dbus-devel \
    devtoolset-9-gcc \
    dpkg \
    elfutils-devel \
    elfutils-libelf-devel \
    expect \
    file-devel \
    gcc \
    gettext-devel \
    git \
    gnupg1 \
    gnupg2 \
    glibc-devel \
    ima-evm-utils-devel \
    libacl-devel \
    libarchive-devel \
    libcap-devel \
    libGL-devel \
    libtool \
    libX11-devel \
    libXdmcp-devel \
    libXext-devel \
    libXfont2-devel \
    libXi-devel \
    libxkbfile-devel \
    libxshmfence-devel \
    libXt-devel \
    libzstd-devel \
    lua-devel \
    make \
    mesa-libgbm-devel \
    ncurses-devel \
    openssl-devel \
    pam-devel \
    perl-ExtUtils-MakeMaker \
    pixman-devel \
    popt-devel \
    python2-devel \
    python3-devel \
    readline-devel \
    redhat-rpm-config \
    rpm-build \
    wget \
    xorg-x11-xtrans-devel \
    xz-devel \
    zip \
    zstd \
 && mkdir -p /opt/cmake \
 && wget https://cmake.org/files/v3.21/cmake-3.21.7-linux-x86_64.tar.gz -O - | tar xz -C /opt/cmake --strip-components 1 \
 && pushd /opt \
 && wget 'https://developer.arm.com/-/media/Files/downloads/gnu-a/9.2-2019.12/binrel/gcc-arm-9.2-2019.12-x86_64-aarch64-none-linux-gnu.tar.xz?revision=61c3be5d-5175-4db6-9030-b565aae9f766&hash=CB9A16FCC54DC7D64F8BBE8D740E38A8BF2C8665' \
 && tar xf 'gcc-arm-9.2-2019.12-x86_64-aarch64-none-linux-gnu.tar.xz?revision=61c3be5d-5175-4db6-9030-b565aae9f766&hash=CB9A16FCC54DC7D64F8BBE8D740E38A8BF2C8665' \
 && rm 'gcc-arm-9.2-2019.12-x86_64-aarch64-none-linux-gnu.tar.xz?revision=61c3be5d-5175-4db6-9030-b565aae9f766&hash=CB9A16FCC54DC7D64F8BBE8D740E38A8BF2C8665' \
 && mv gcc-arm-9.2-2019.12-x86_64-aarch64-none-linux-gnu gcc.arm64 \
 && rm -rf /opt/gcc.arm64/aarch64-none-linux-gnu/bin/ld.gold \
           /opt/gcc.arm64/aarch64-none-linux-gnu/include \
           /opt/gcc.arm64/aarch64-none-linux-gnu/lib64/*atomic* \
           /opt/gcc.arm64/aarch64-none-linux-gnu/lib64/*fortran* \
           /opt/gcc.arm64/aarch64-none-linux-gnu/lib64/*gomp* \
           /opt/gcc.arm64/aarch64-none-linux-gnu/lib64/*itm* \
           /opt/gcc.arm64/aarch64-none-linux-gnu/lib64/*san* \
           /opt/gcc.arm64/aarch64-none-linux-gnu/lib64/*++* \
           /opt/gcc.arm64/aarch64-none-linux-gnu/libc/usr/bin \
           /opt/gcc.arm64/aarch64-none-linux-gnu/libc/usr/lib64/*atomic* \
           /opt/gcc.arm64/aarch64-none-linux-gnu/libc/usr/lib64/*fortran* \
           /opt/gcc.arm64/aarch64-none-linux-gnu/libc/usr/lib64/*gomp* \
           /opt/gcc.arm64/aarch64-none-linux-gnu/libc/usr/lib64/*san* \
           /opt/gcc.arm64/aarch64-none-linux-gnu/libc/usr/lib64/*stdc++* \
           /opt/gcc.arm64/bin/*++* \
           /opt/gcc.arm64/bin/*fortran* \
           /opt/gcc.arm64/bin/*gcov* \
           /opt/gcc.arm64/bin/*gdb* \
           /opt/gcc.arm64/bin/*ld.gold* \
           /opt/gcc.arm64/lib/gcc/aarch64-none-linux-gnu/9.2.1/*gcov* \
           /opt/gcc.arm64/lib/gcc/aarch64-none-linux-gnu/9.2.1/plugin \
           /opt/gcc.arm64/libexec/gcc/aarch64-none-linux-gnu/9.2.1/cc1plus \
           /opt/gcc.arm64/libexec/gcc/aarch64-none-linux-gnu/9.2.1/f951 \
           /opt/gcc.arm64/libexec/gcc/aarch64-none-linux-gnu/9.2.1/lto* \
           /opt/gcc.arm64/libexec/gcc/aarch64-none-linux-gnu/9.2.1/plugin \
           /opt/gcc.arm64/share \
 && chown -R root:root gcc.arm64 \
 && mkdir arm64 \
 && pushd arm64 \
 && rpm2cpio https://vault.centos.org/altarch/7.9.2009/os/aarch64/Packages/audit-libs-2.8.5-4.el7.aarch64.rpm | cpio -idv \
 && rpm2cpio https://vault.centos.org/altarch/7.9.2009/os/aarch64/Packages/bzip2-libs-1.0.6-13.el7.aarch64.rpm | cpio -idv \
 && rpm2cpio https://vault.centos.org/altarch/7.9.2009/os/aarch64/Packages/bzip2-devel-1.0.6-13.el7.aarch64.rpm | cpio -idv \
 && rpm2cpio https://vault.centos.org/altarch/7.9.2009/updates/aarch64/Packages//expat-2.1.0-15.el7_9.aarch64.rpm | cpio -idv \
 && rpm2cpio https://vault.centos.org/altarch/7.9.2009/updates/aarch64/Packages//freetype-2.8-14.el7_9.1.aarch64.rpm | cpio -idv \
 && rpm2cpio https://vault.centos.org/altarch/7.9.2009/updates/aarch64/Packages//freetype-devel-2.8-14.el7_9.1.aarch64.rpm | cpio -idv \
 && rpm2cpio https://vault.centos.org/altarch/7.9.2009/updates/aarch64/Packages//glibc-2.17-326.el7_9.aarch64.rpm | cpio -idv \
 && rpm2cpio https://vault.centos.org/altarch/7.9.2009/updates/aarch64/Packages//glibc-devel-2.17-326.el7_9.aarch64.rpm | cpio -idv \
 && rpm2cpio https://vault.centos.org/altarch/7.9.2009/updates/aarch64/Packages//krb5-devel-1.15.1-55.el7_9.aarch64.rpm | cpio -idv \
 && rpm2cpio https://vault.centos.org/altarch/7.9.2009/os/aarch64/Packages/libcap-ng-0.7.5-4.el7.aarch64.rpm | cpio -idv \
 && rpm2cpio https://vault.centos.org/altarch/7.9.2009/os/aarch64/Packages/libcom_err-devel-1.42.9-19.el7.aarch64.rpm | cpio -idv \
 && rpm2cpio https://vault.centos.org/altarch/7.9.2009/os/aarch64/Packages/libdrm-2.4.97-2.el7.aarch64.rpm | cpio -idv \
 && rpm2cpio https://vault.centos.org/altarch/7.9.2009/os/aarch64/Packages/libdrm-devel-2.4.97-2.el7.aarch64.rpm | cpio -idv \
 && rpm2cpio https://vault.centos.org/altarch/7.9.2009/os/aarch64/Packages/libffi-3.0.13-19.el7.aarch64.rpm | cpio -idv \
 && rpm2cpio https://vault.centos.org/altarch/7.9.2009/os/aarch64/Packages/libfontenc-1.1.3-3.el7.aarch64.rpm | cpio -idv \
 && rpm2cpio https://vault.centos.org/altarch/7.9.2009/os/aarch64/Packages/libfontenc-devel-1.1.3-3.el7.aarch64.rpm | cpio -idv \
 && rpm2cpio https://vault.centos.org/altarch/7.9.2009/os/aarch64/Packages/libglvnd-1.0.1-0.8.git5baa1e5.el7.aarch64.rpm | cpio -idv \
 && rpm2cpio https://vault.centos.org/altarch/7.9.2009/os/aarch64/Packages/libglvnd-devel-1.0.1-0.8.git5baa1e5.el7.aarch64.rpm | cpio -idv \
 && rpm2cpio https://vault.centos.org/altarch/7.9.2009/os/aarch64/Packages/libglvnd-glx-1.0.1-0.8.git5baa1e5.el7.aarch64.rpm | cpio -idv \
 && rpm2cpio https://vault.centos.org/altarch/7.9.2009/os/aarch64/Packages/libICE-1.0.9-9.el7.aarch64.rpm | cpio -idv \
 && rpm2cpio https://vault.centos.org/altarch/7.9.2009/os/aarch64/Packages/libICE-devel-1.0.9-9.el7.aarch64.rpm | cpio -idv \
 && rpm2cpio https://vault.centos.org/altarch/7.9.2009/os/aarch64/Packages/libpng-1.5.13-8.el7.aarch64.rpm | cpio -idv \
 && rpm2cpio https://vault.centos.org/altarch/7.9.2009/os/aarch64/Packages/libpng-devel-1.5.13-8.el7.aarch64.rpm | cpio -idv \
 && rpm2cpio https://vault.centos.org/altarch/7.9.2009/os/aarch64/Packages/libSM-1.2.2-2.el7.aarch64.rpm | cpio -idv \
 && rpm2cpio https://vault.centos.org/altarch/7.9.2009/os/aarch64/Packages/libSM-devel-1.2.2-2.el7.aarch64.rpm | cpio -idv \
 && rpm2cpio https://vault.centos.org/altarch/7.9.2009/updates/aarch64/Packages//libuuid-2.23.2-65.el7_9.1.aarch64.rpm | cpio -idv \
 && rpm2cpio https://vault.centos.org/altarch/7.9.2009/os/aarch64/Packages/libwayland-server-1.15.0-1.el7.aarch64.rpm | cpio -idv \
 && rpm2cpio https://vault.centos.org/altarch/7.9.2009/updates/aarch64/Packages//libX11-1.6.7-4.el7_9.aarch64.rpm | cpio -idv \
 && rpm2cpio https://vault.centos.org/altarch/7.9.2009/updates/aarch64/Packages//libX11-devel-1.6.7-4.el7_9.aarch64.rpm | cpio -idv \
 && rpm2cpio https://vault.centos.org/altarch/7.9.2009/os/aarch64/Packages/libXau-1.0.8-2.1.el7.aarch64.rpm | cpio -idv \
 && rpm2cpio https://vault.centos.org/altarch/7.9.2009/os/aarch64/Packages/libXau-devel-1.0.8-2.1.el7.aarch64.rpm | cpio -idv \
 && rpm2cpio https://vault.centos.org/altarch/7.9.2009/os/aarch64/Packages/libxcb-1.13-1.el7.aarch64.rpm | cpio -idv \
 && rpm2cpio https://vault.centos.org/altarch/7.9.2009/os/aarch64/Packages/libXdmcp-1.1.2-6.el7.aarch64.rpm | cpio -idv \
 && rpm2cpio https://vault.centos.org/altarch/7.9.2009/os/aarch64/Packages/libXdmcp-devel-1.1.2-6.el7.aarch64.rpm | cpio -idv \
 && rpm2cpio https://vault.centos.org/altarch/7.9.2009/os/aarch64/Packages/libXext-1.3.3-3.el7.aarch64.rpm | cpio -idv \
 && rpm2cpio https://vault.centos.org/altarch/7.9.2009/os/aarch64/Packages/libXext-devel-1.3.3-3.el7.aarch64.rpm | cpio -idv \
 && rpm2cpio https://vault.centos.org/altarch/7.9.2009/os/aarch64/Packages/libXfixes-devel-5.0.3-1.el7.aarch64.rpm | cpio -idv \
 && rpm2cpio https://vault.centos.org/altarch/7.9.2009/os/aarch64/Packages/libXfont2-2.0.3-1.el7.aarch64.rpm | cpio -idv \
 && rpm2cpio https://vault.centos.org/altarch/7.9.2009/os/aarch64/Packages/libXfont2-devel-2.0.3-1.el7.aarch64.rpm | cpio -idv \
 && rpm2cpio https://vault.centos.org/altarch/7.9.2009/os/aarch64/Packages/libXi-1.7.9-1.el7.aarch64.rpm | cpio -idv \
 && rpm2cpio https://vault.centos.org/altarch/7.9.2009/os/aarch64/Packages/libXi-devel-1.7.9-1.el7.aarch64.rpm | cpio -idv \
 && rpm2cpio https://vault.centos.org/altarch/7.9.2009/os/aarch64/Packages/libxkbfile-1.0.9-3.el7.aarch64.rpm | cpio -idv \
 && rpm2cpio https://vault.centos.org/altarch/7.9.2009/os/aarch64/Packages/libxkbfile-devel-1.0.9-3.el7.aarch64.rpm | cpio -idv \
 && rpm2cpio https://vault.centos.org/altarch/7.9.2009/os/aarch64/Packages/libxshmfence-1.2-1.el7.aarch64.rpm | cpio -idv \
 && rpm2cpio https://vault.centos.org/altarch/7.9.2009/os/aarch64/Packages/libxshmfence-devel-1.2-1.el7.aarch64.rpm | cpio -idv \
 && rpm2cpio https://vault.centos.org/altarch/7.9.2009/updates/aarch64/Packages//mesa-libgbm-18.3.4-12.el7_9.aarch64.rpm | cpio -idv \
 && rpm2cpio https://vault.centos.org/altarch/7.9.2009/updates/aarch64/Packages//mesa-libgbm-devel-18.3.4-12.el7_9.aarch64.rpm | cpio -idv \
 && rpm2cpio https://vault.centos.org/altarch/7.9.2009/updates/aarch64/Packages//mesa-libGL-18.3.4-12.el7_9.aarch64.rpm | cpio -idv \
 && rpm2cpio https://vault.centos.org/altarch/7.9.2009/updates/aarch64/Packages//mesa-libGL-devel-18.3.4-12.el7_9.aarch64.rpm | cpio -idv \
 && rpm2cpio https://vault.centos.org/altarch/7.9.2009/updates/aarch64/Packages//mesa-khr-devel-18.3.4-12.el7_9.aarch64.rpm | cpio -idv \
 && rpm2cpio https://vault.centos.org/altarch/7.9.2009/updates/aarch64/Packages//openssl-libs-1.0.2k-26.el7_9.aarch64.rpm | cpio -idv \
 && rpm2cpio https://vault.centos.org/altarch/7.9.2009/updates/aarch64/Packages//openssl-devel-1.0.2k-26.el7_9.aarch64.rpm | cpio -idv \
 && rpm2cpio https://vault.centos.org/altarch/7.9.2009/os/aarch64/Packages/pam-1.1.8-23.el7.aarch64.rpm | cpio -idv \
 && rpm2cpio https://vault.centos.org/altarch/7.9.2009/os/aarch64/Packages/pam-devel-1.1.8-23.el7.aarch64.rpm | cpio -idv \
 && rpm2cpio https://vault.centos.org/altarch/7.9.2009/os/aarch64/Packages/pixman-0.34.0-1.el7.aarch64.rpm | cpio -idv \
 && rpm2cpio https://vault.centos.org/altarch/7.9.2009/os/aarch64/Packages/pixman-devel-0.34.0-1.el7.aarch64.rpm | cpio -idv \
 && rpm2cpio https://vault.centos.org/altarch/7.9.2009/os/aarch64/Packages/xorg-x11-proto-devel-2018.4-1.el7.noarch.rpm | cpio -idv \
 && rpm2cpio https://vault.centos.org/altarch/7.9.2009/os/aarch64/Packages/xorg-x11-xtrans-devel-1.3.5-1.el7.noarch.rpm | cpio -idv \
 && rpm2cpio https://vault.centos.org/altarch/7.9.2009/updates/aarch64/Packages//zlib-1.2.7-21.el7_9.aarch64.rpm | cpio -idv \
 && rpm2cpio https://vault.centos.org/altarch/7.9.2009/updates/aarch64/Packages//zlib-devel-1.2.7-21.el7_9.aarch64.rpm | cpio -idv \
 && popd \
 && popd \
 && ln -fs /opt/arm64/usr/lib64/libm.so /opt/gcc.arm64/aarch64-none-linux-gnu/libc/usr/lib64/libm.so \
 && mkdir ~/rpm \
 && pushd ~/rpm \
 && wget https://dl.rockylinux.org/vault/rocky/8.4/BaseOS/source/tree/Packages/rpm-4.14.3-13.el8.src.rpm \
 && rpmbuild --rebuild rpm-4.14.3-13.el8.src.rpm \
 && popd \
 && rm -rf ~/rpm \
 && pushd ~/rpmbuild/RPMS/x86_64 \
 && rpm -Uvh rpm-4* rpm-libs-* rpm-build-* python2-rpm-* rpm-sign-* \
 && popd \
 && rm -rf ~/rpmbuild \
 && mkdir ~/src \
 && git clone --depth=1 https://gitlab.com/debsigs/debsigs.git ~/src/debsigs \
 && pushd ~/src/debsigs \
 && git fetch --tags \
 && git checkout debsigs-0.1.18-debian \
 && echo -e '--- a/debsigs\n+++ b/debsigs\n@@ -101,7 +101,7 @@ sub cmd_sign($) {\n   #  my $gpgout = forktools::forkboth($arfd, $sigfile, "/usr/bin/gpg",\n   #"--detach-sign");\n \n-  my @cmdline = ("gpg", "--openpgp", "--detach-sign");\n+  my @cmdline = ("gpg1", "--openpgp", "--detach-sign");\n \n   if ($key) {\n     push (@cmdline, "--default-key", $key);' >patch \
 && patch -p1 <patch \
 && perl Makefile.PL \
 && make install \
 && popd \
 && rm -rf ~/src \
 && yum -y autoremove \
    audit-libs-devel \
    automake \
    binutils-devel \
    db4-cxx \
    dbus-devel \
    elfutils-devel \
    elfutils-libelf-devel \
    file-devel \
    gdbm-devel \
    gettext-devel \
    ima-evm-utils-devel \
    libacl-devel \
    libarchive-devel \
    libcap-devel \
    libtool \
    libzstd-devel \
    lua-devel \
    ncurses-devel \
    perl-ExtUtils-MakeMaker \
    popt-devel \
    python2-devel \
    python3-devel \
    readline-devel \
    xz-devel \
 && yum -y install \
    python3 \
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
ENV PATH /opt/cmake/bin:${PATH}

# Set default command
CMD ["/bin/bash"]
