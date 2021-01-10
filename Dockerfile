#FROM ubuntu
FROM alpine as build

LABEL maintainer Alexander Hanl <ttt.aalmann@web.de>

RUN apk add --update --no-cache git make go
# musl-dev go


# Configure Go
ENV GOROOT /usr/lib/go
ENV GOPATH /go
ENV PATH /go/bin:$PATH
ENV GH_CLI_INSTALL /gh_cli

WORKDIR $GOPATH

RUN go version && \
    git clone https://github.com/cli/cli.git gh-cli && \
    cd gh-cli && \
    make install && \
    make install prefix=${GH_CLI_INSTALL} && \
    ls -la ${GH_CLI_INSTALL} && \ 
    ls -la ${GH_CLI_INSTALL}/bin && \
    chmod 777 ${GH_CLI_INSTALL}/bin/gh && \
    ${GH_CLI_INSTALL}/bin/gh version

FROM alpine
ENV GH_CLI_INSTALL /gh_cli
ENV GH_API_TOKEN invalid_token
COPY --from=build ${GH_CLI_INSTALL}/* /usr/local/bin
COPY docker-entrypoint.sh /usr/local/bin
RUN chmod 777 /usr/local/bin/docker-entrypoint.sh

VOLUME /gh
WORKDIR /gh

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
#ENTRYPOINT [ "&&", "echo token ${GH_API_TOKEN}", "&&", "gh"]
CMD ["--help"]