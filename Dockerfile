FROM debian:10-slim AS download
RUN apt-get update && apt-get install -y curl unzip
WORKDIR /download
RUN curl -OL http://ccb.jhu.edu/software/stringtie/dl/stringtie-2.1.1.Linux_x86_64.tar.gz
RUN tar xzf stringtie-2.1.1.Linux_x86_64.tar.gz

FROM debian:10-slim
COPY --from=download /download/stringtie-2.1.1.Linux_x86_64 /opt/stringtie-2.1.1.Linux_x86_64
ENV PATH=/opt/stringtie-2.1.1.Linux_x86_64:${PATH}
ADD run.sh /
ENTRYPOINT [ "/bin/bash", "/run.sh" ]
