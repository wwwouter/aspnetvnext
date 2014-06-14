FROM    ubuntu:14.04
MAINTAINER Wouter Mooij

RUN	apt-get -y update
RUN	apt-get -y install curl unzip git-core build-essential autoconf libtool gettext libgdiplus libgtk2.0-0 xsltproc
RUN 	cd /tmp; git clone git://github.com/mono/mono.git
RUN	cd /tmp/mono; ./autogen.sh --prefix=/usr --with-mcs-docs=no
RUN	cd /tmp/mono; make get-monolite-latest
RUN	cd /tmp/mono; make EXTERNAL_MCS="${PWD}/mcs/class/lib/monolite/gmcs.exe"
RUN	cd /tmp/mono; make install
RUN	apt-get install -y pkg-config
RUN	cd /tmp/mono/scripts; ./mono-test-install
RUN	mozroots --import --sync
ENV   HOME  /root
RUN   /bin/bash -c "curl https://raw.githubusercontent.com/graemechristie/Home/KvmShellImplementation/kvmsetup.sh | sh && source ~/.kre/kvm/kvm.sh && kvm upgrade"
RUN	git clone https://github.com/davidfowl/HelloWorldVNext ~/helloworld
RUN	/bin/bash -c "source ~/.kre/kvm/kvm.sh && cd ~/helloworld/ && kpm restore"
