FROM ubuntu:16.04
MAINTAINER Alec Posney

RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get install -y git build-essential zlib1g-dev libncurses5-dev libssl-dev libpcre2-dev wget libsnappy-dev liblz4-dev python-dev cmake

RUN echo "\ndeb http://apt.llvm.org/xenial/ llvm-toolchain-xenial-3.9 main \ndeb-src http://apt.llvm.org/xenial/ llvm-toolchain-xenial-3.9 main" >> /etc/apt/sources.list

RUN wget --quiet http://apt.llvm.org/llvm-snapshot.gpg.key -O  /tmp/llvm-snapshot.gpg.key; apt-key add /tmp/llvm-snapshot.gpg.key
RUN wget --quiet https://github.com/WallarooLabs/wallaroo/archive/0.1.2.tar.gz -O /tmp/0.1.2.tar.gz; tar -xvzf /tmp/0.1.2.tar.gz -C /opt/; mv /opt/wallaroo-0.1.2 /opt/wallaroo
RUN wget --quiet https://github.com/WallarooLabs/ponyc/archive/wallaroolabs-19.2.14.tar.gz -O /tmp/wallaroolabs-19.2.14.tar.gz; tar -xvzf /tmp/wallaroolabs-19.2.14.tar.gz -C /opt/

RUN apt-get update
RUN apt-get install -y llvm-3.9

WORKDIR /opt/

RUN cd ponyc-wallaroolabs-19.2.14; \
    make config=release install;

RUN git clone --quiet https://github.com/ponylang/pony-stable; \
    cd pony-stable; \
    git checkout 0054b429a54818d187100ed40f5525ec7931b31b; \
    make; \
    make install;

RUN cd /opt/wallaroo/machida; \
    make; \
    ln -s /opt/wallaroo/machida/build/machida /usr/bin/machida; \
    ln -s /opt/wallaroo/machida/build/machida_resilience /usr/bin/machida_resilience;

RUN cd /opt/wallaroo/giles/sender; \
    make; \
    ln -s /opt/wallaroo/giles/sender/sender /usr/bin/sender;

RUN cd /opt/wallaroo/giles/receiver; \
    make; \
    ln -s /opt/wallaroo/giles/receiver/receiver /usr/bin/receiver;

RUN cd /opt/wallaroo/utils/cluster_shutdown; \
    make; \
    ln -s /opt/wallaroo/utils/cluster_shutdown/cluster_shutdown /usr/bin/cluster_shutdown;
