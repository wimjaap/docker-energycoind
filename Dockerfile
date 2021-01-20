FROM ubuntu:18.04
WORKDIR /root/
RUN apt-get update \
&& apt-get dist-upgrade -y \
&& apt-get install -y gnupg \
&& apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C70EF1F0305A1ADB9986DBD8D46F45428842CE5E  \
&& echo "deb http://ppa.launchpad.net/bitcoin/bitcoin/ubuntu bionic main" > /etc/apt/sources.list.d/bitcoin.list \
&& apt-get update  \
&& apt-get install -y build-essential libdb++-dev libssl1.0-dev libminiupnpc-dev zlib1g-dev libboost-system1.65-dev libboost-filesystem1.65-dev libboost-chrono1.65-dev libboost-program-options1.65-dev libboost-test1.65-dev libboost-thread1.65-dev git \
&& apt-get clean  \
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
&& git clone https://github.com/wimjaap/energycoin.git \
&& cd energycoin/src \
&& make -f makefile.unix -j $(nproc --all) USE_UPNP=0

FROM ubuntu:18.04
RUN apt-get update \
&& apt-get install -y gnupg \
&& apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C70EF1F0305A1ADB9986DBD8D46F45428842CE5E  \
&& echo "deb http://ppa.launchpad.net/bitcoin/bitcoin/ubuntu bionic main" > /etc/apt/sources.list.d/bitcoin.list \
&& apt-get update  \
&& apt-get install -y libdb5.3++ libssl1.0 miniupnpc libboost-system1.65.1 libboost-filesystem1.65.1 libboost-chrono1.65.1 libboost-program-options1.65.1 libboost-test1.65.1 libboost-thread1.65.1 curl wget p7zip-full  \
&& apt-get clean  \
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
COPY --from=0 /root/energycoin/src/energycoind /usr/bin/energycoind
COPY run.sh /usr/bin/run.sh
RUN chmod +x /usr/bin/run.sh
EXPOSE 22705 22706
WORKDIR /energycoin
ENTRYPOINT ["/usr/bin/run.sh"]
