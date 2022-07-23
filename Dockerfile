FROM debian:11.4-slim AS installer
RUN apt-get update\
 && apt-get install --no-install-recommends -y wget=* perl=* xz-utils=* gnupg=* ca-certificates=*\
 && rm -rf /var/lib/apt/lists/*
COPY ./texlive.profile ./
RUN wget -nv https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz\
 && tar -xf install-tl-unx.tar.gz && cd install-tl-*\
 && echo I | ./install-tl -scheme scheme-basic --repository https://mirror.ctan.org/systems/texlive/tlnet/\
 && cd .. && rm -rf install-tl*

FROM debian:11.4-slim
ENV PATH /usr/local/texlive/bin:$PATH
COPY --from=installer /usr/local/texlive /usr/local/texlive
RUN apt-get update\
 && apt-get install -y perl wget\
 && rm -rf /var/lib/apt/lists/*
RUN ln -sf /usr/local/texlive/*/bin/* /usr/local/texlive/bin
RUN which tlmgr
RUN echo $PATH
RUN tlmgr option repository https://mirror.ctan.org/systems/texlive/tlnet
CMD ["bash"]
