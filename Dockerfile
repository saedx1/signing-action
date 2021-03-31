FROM alpine:3.13.3

RUN apk add autoconf automake libtool make build-base gcc abuild binutils binutils-doc gcc-doc openssl-dev curl-dev git

RUN apk add --no-cache \
        python3 \
        py3-pip \
    && pip3 install --upgrade pip \
    && pip3 install \
        awscli \
    && rm -rf /var/cache/apk/*
    
WORKDIR /
RUN git clone https://github.com/mtrojnar/osslsigncode.git
WORKDIR /osslsigncode
RUN ./autogen.sh
RUN ./configure
RUN make
RUN make install

RUN mkdir /work

WORKDIR /work

ENTRYPOINT ["/bin/sh"]