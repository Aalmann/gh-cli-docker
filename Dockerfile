FROM alpine as build

LABEL maintainer Alexander Hanl <ttt.aalmann@web.de>

# Configure Go
ENV GOROOT /usr/lib/go
ENV GOPATH /go
ENV PATH /go/bin:$PATH
ENV GH_CLI_INSTALL /gh_cli
ENV CLI_GIT_REFERENCE trunk

WORKDIR $GOPATH

RUN apk add --update --no-cache git make go && \
    go version && \
    git clone https://github.com/cli/cli.git gh-cli && \
    cd gh-cli && \
    git checkout -d ${CLI_GIT_REFERENCE} && \
    make install && \
    make install prefix=${GH_CLI_INSTALL} && \
    ls -la ${GH_CLI_INSTALL} && \ 
    ls -la ${GH_CLI_INSTALL}/bin && \
    chmod 777 ${GH_CLI_INSTALL}/bin/gh && \
    ${GH_CLI_INSTALL}/bin/gh version

FROM alpine

ENV GH_CLI_INSTALL /gh_cli

COPY --from=build ${GH_CLI_INSTALL}/* /usr/local/bin/

COPY docker-entrypoint.sh /usr/local/bin/
RUN apk add --update --no-cache git && \
    chmod 777 /usr/local/bin/docker-entrypoint.sh

VOLUME /gh
WORKDIR /gh

ENTRYPOINT ["sh", "/usr/local/bin/docker-entrypoint.sh"]
CMD ["--help"]
