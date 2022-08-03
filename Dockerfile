# syntax=docker/dockerfile:1

ARG BASE_IMG_TAG=nonroot

# --------------------------------------------------------
# Install er
# --------------------------------------------------------

FROM golang:1.18.2-alpine3.15 as build

# TODO: Move to Github Release when repo is public

WORKDIR /berachain
COPY . /berachain
ADD https://berad-temp-bucket.s3.amazonaws.com/berad_nightly_linux_amd64.tar.gz /berachain
RUN tar -xzf /berachain/berad_nightly_linux_amd64.tar.gz -C /berachain

# --------------------------------------------------------
# Runner
# --------------------------------------------------------

FROM gcr.io/distroless/base-debian11:${BASE_IMG_TAG}

COPY --from=build /berachain/berad /bin/berad

ENV HOME /berachain
WORKDIR $HOME

EXPOSE 26656
EXPOSE 26657
EXPOSE 8545
EXPOSE 8546
EXPOSE 1317

ENTRYPOINT ["berad"]
CMD [ "start" ]