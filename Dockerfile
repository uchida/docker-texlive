FROM debian:9
MAINTAINER Akihiro Uchida <uchida@turbare.net>
RUN apt-get update\
 && apt-get install --no-install-recommends -y wget=* perl=5.24.* perl-modules-5.24=* xz-utils=* gnupg=*\
 && rm -rf /var/lib/apt/lists/*
ENV INSTALL_TL_SUM 954a64f2ff8d387aed7f677d43cc7836d88556ed6efedc32ad96626fca1f23c7
RUN wget -q http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz\
 && echo "$INSTALL_TL_SUM  install-tl-unx.tar.gz" | sha256sum -c --strict -\
 && tar -xzf install-tl-unx.tar.gz && cd install-tl-*\
 && echo I | ./install-tl -scheme scheme-basic --repository http://mirror.ctan.org/systems/texlive/tlnet/\
 && cd .. && rm -rf install-tl*\
 && /usr/local/texlive/2018/bin/x86_64-linux/tlmgr option repository http://mirror.ctan.org/systems/texlive/tlnet
ENV PATH /usr/local/texlive/2018/bin/x86_64-linux:$PATH
