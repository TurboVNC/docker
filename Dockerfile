FROM centos:6

RUN cat /etc/yum.repos.d/CentOS-Base.repo | sed s/^mirrorlist=/#mirrorlist=/g | sed 's@^#baseurl=http://mirror\.centos\.org/centos/\$releasever@baseurl=http://vault.centos.org/6.10@g' >/etc/yum.repos.d/CentOS-Base.repo.new \
 && mv -f /etc/yum.repos.d/CentOS-Base.repo.new /etc/yum.repos.d/CentOS-Base.repo \
 && cat /etc/yum.repos.d/CentOS-fasttrack.repo | sed s/^mirrorlist=/#mirrorlist=/g | sed 's@^#baseurl=http://mirror\.centos\.org/centos/\$releasever@baseurl=http://vault.centos.org/6.10@g' >/etc/yum.repos.d/CentOS-fasttrack.repo.new \
 && mv -f /etc/yum.repos.d/CentOS-fasttrack.repo.new /etc/yum.repos.d/CentOS-fasttrack.repo \
 && yum -y update \
 && yum -y install epel-release.noarch \
 && yum -y install \
    dpkg.x86_64 \
    expect.x86_64 \
    gcc.x86_64 \
    gnupg.x86_64 \
    glibc-devel.x86_64 \
    glibc-devel.i686 \
    git.x86_64 \
    http://vault.centos.org/centos/6/updates/i386/Packages/java-1.8.0-openjdk-1.8.0.275.b01-0.el6_10.i686.rpm \
    http://vault.centos.org/centos/6/updates/i386/Packages/java-1.8.0-openjdk-devel-1.8.0.275.b01-0.el6_10.i686.rpm \
    http://vault.centos.org/centos/6/updates/i386/Packages/java-1.8.0-openjdk-headless-1.8.0.275.b01-0.el6_10.i686.rpm \
    libgcc.i686 \
    libX11-devel.x86_64 \
    libX11-devel.i686 \
    libXext-devel.x86_64 \
    libXext-devel.i686 \
    libXi-devel.x86_64 \
    libXi-devel.i686 \
    libXt-devel.x86_64 \
    libXt-devel.i686 \
    make.x86_64 \
    openssl-devel.x86_64 \
    openssl-devel.i686 \
    pam-devel.x86_64 \
    pam-devel.i686 \
    python34 \
    redhat-rpm-config \
    rpm-build.x86_64 \
    wget.x86_64 \
    perl-ExtUtils-MakeMaker \
    zip.x86_64 \
    https://www.rpmfind.net/linux/remi/enterprise/6/remi/x86_64/gnupg1-1.4.23-1.el6.remi.x86_64.rpm \
 && mkdir -p /opt/cmake \
 && wget https://cmake.org/files/v3.14/cmake-3.14.7-Linux-x86_64.tar.gz -O - | tar xz -C /opt/cmake --strip-components 1 \
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
 && rpm2cpio http://mirror.centos.org/altarch/7/os/aarch64/Packages/audit-libs-2.8.5-4.el7.aarch64.rpm | cpio -idv \
 && rpm2cpio http://mirror.centos.org/altarch/7/updates/aarch64/Packages/glibc-2.17-325.el7_9.aarch64.rpm | cpio -idv \
 && rpm2cpio http://mirror.centos.org/altarch/7/updates/aarch64/Packages/glibc-devel-2.17-325.el7_9.aarch64.rpm | cpio -idv \
 && rpm2cpio http://mirror.centos.org/altarch/7/updates/aarch64/Packages/krb5-devel-1.15.1-51.el7_9.aarch64.rpm | cpio -idv \
 && rpm2cpio http://mirror.centos.org/altarch/7/os/aarch64/Packages/libcap-ng-0.7.5-4.el7.aarch64.rpm | cpio -idv \
 && rpm2cpio http://mirror.centos.org/altarch/7/os/aarch64/Packages/libcom_err-devel-1.42.9-19.el7.aarch64.rpm | cpio -idv \
 && rpm2cpio http://mirror.centos.org/altarch/7/os/aarch64/Packages/libICE-1.0.9-9.el7.aarch64.rpm | cpio -idv \
 && rpm2cpio http://mirror.centos.org/altarch/7/os/aarch64/Packages/libICE-devel-1.0.9-9.el7.aarch64.rpm | cpio -idv \
 && rpm2cpio http://mirror.centos.org/altarch/7/os/aarch64/Packages/libSM-1.2.2-2.el7.aarch64.rpm | cpio -idv \
 && rpm2cpio http://mirror.centos.org/altarch/7/os/aarch64/Packages/libSM-devel-1.2.2-2.el7.aarch64.rpm | cpio -idv \
 && rpm2cpio http://mirror.centos.org/altarch/7/updates/aarch64/Packages/libuuid-2.23.2-65.el7_9.1.aarch64.rpm | cpio -idv \
 && rpm2cpio http://mirror.centos.org/altarch/7/updates/aarch64/Packages/libX11-1.6.7-4.el7_9.aarch64.rpm | cpio -idv \
 && rpm2cpio http://mirror.centos.org/altarch/7/updates/aarch64/Packages/libX11-devel-1.6.7-4.el7_9.aarch64.rpm | cpio -idv \
 && rpm2cpio http://mirror.centos.org/altarch/7/os/aarch64/Packages/libXau-1.0.8-2.1.el7.aarch64.rpm | cpio -idv \
 && rpm2cpio http://mirror.centos.org/altarch/7/os/aarch64/Packages/libXau-devel-1.0.8-2.1.el7.aarch64.rpm | cpio -idv \
 && rpm2cpio http://mirror.centos.org/altarch/7/os/aarch64/Packages/libxcb-1.13-1.el7.aarch64.rpm | cpio -idv \
 && rpm2cpio http://mirror.centos.org/altarch/7/os/aarch64/Packages/libXext-1.3.3-3.el7.aarch64.rpm | cpio -idv \
 && rpm2cpio http://mirror.centos.org/altarch/7/os/aarch64/Packages/libXext-devel-1.3.3-3.el7.aarch64.rpm | cpio -idv \
 && rpm2cpio http://mirror.centos.org/altarch/7/os/aarch64/Packages/libXfixes-devel-5.0.3-1.el7.aarch64.rpm | cpio -idv \
 && rpm2cpio http://mirror.centos.org/altarch/7/os/aarch64/Packages/libXi-1.7.9-1.el7.aarch64.rpm | cpio -idv \
 && rpm2cpio http://mirror.centos.org/altarch/7/os/aarch64/Packages/libXi-devel-1.7.9-1.el7.aarch64.rpm | cpio -idv \
 && rpm2cpio http://mirror.centos.org/altarch/7/updates/aarch64/Packages/openssl-libs-1.0.2k-24.el7_9.aarch64.rpm | cpio -idv \
 && rpm2cpio http://mirror.centos.org/altarch/7/updates/aarch64/Packages/openssl-devel-1.0.2k-24.el7_9.aarch64.rpm | cpio -idv \
 && rpm2cpio http://mirror.centos.org/altarch/7/os/aarch64/Packages/pam-1.1.8-23.el7.aarch64.rpm | cpio -idv \
 && rpm2cpio http://mirror.centos.org/altarch/7/os/aarch64/Packages/pam-devel-1.1.8-23.el7.aarch64.rpm | cpio -idv \
 && rpm2cpio http://mirror.centos.org/altarch/7/os/aarch64/Packages/xorg-x11-proto-devel-2018.4-1.el7.noarch.rpm | cpio -idv \
 && popd \
 && popd \
 && ln -fs /opt/arm64/usr/lib64/libm.so /opt/gcc.arm64/aarch64-none-linux-gnu/libc/usr/lib64/libm.so \
 && mkdir ~/rpm \
 && pushd ~/rpm \
 && rpm2cpio http://mirror.centos.org/altarch/7/updates/aarch64/Packages/rpm-4.11.3-48.el7_9.aarch64.rpm | cpio -idv \
 && mv usr/lib/rpm/platform/aarch64-linux /usr/lib/rpm/platform \
 && popd \
 && rm -rf ~/rpm \
 && mkdir ~/src \
 && git clone --depth=1 https://gitlab.com/debsigs/debsigs.git ~/src/debsigs \
 && pushd ~/src/debsigs \
 && git checkout debsigs-0.1.15%7Eroam1 \
 && echo -e '--- a/debsigs\n+++ b/debsigs\n@@ -101,7 +101,7 @@ sub cmd_sign($) {\n   #  my $gpgout = forktools::forkboth($arfd, $sigfile, "/usr/bin/gpg",\n   #"--detach-sign");\n \n-  my @cmdline = ("gpg", "--openpgp", "--detach-sign");\n+  my @cmdline = ("gpg1", "--openpgp", "--detach-sign");\n \n   if ($key) {\n     push (@cmdline, "--default-key", $key);' >patch \
 && patch -p1 <patch \
 && perl Makefile.PL \
 && make install \
 && popd \
 && rm -rf ~/src \
 && yum -y remove perl-ExtUtils-MakeMaker gdbm-devel db4-cxx \
 && mkdir /usr/java \
 && ln -fs /usr/lib/jvm/java-1.8.0-openjdk.i386 /usr/java/default32 \
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
