FROM debian:11-slim AS download
RUN apt-get update && apt-get install -y curl unzip
WORKDIR /download
ARG STRINGTIE_VERSION=2.2.1
RUN curl -OL http://ccb.jhu.edu/software/stringtie/dl/stringtie-${STRINGTIE_VERSION}.Linux_x86_64.tar.gz
RUN tar xzf stringtie-${STRINGTIE_VERSION}.Linux_x86_64.tar.gz

FROM debian:11-slim
ARG STRINGTIE_VERSION=2.2.1
COPY --from=download /download/stringtie-${STRINGTIE_VERSION}.Linux_x86_64 /opt/stringtie-${STRINGTIE_VERSION}.Linux_x86_64
ENV PATH=/opt/stringtie-${STRINGTIE_VERSION}.Linux_x86_64:${PATH}
ADD run.sh /
ENTRYPOINT [ "/bin/bash", "/run.sh" ]
