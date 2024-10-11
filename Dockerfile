# Use a minimal, secure base image
FROM debian:stable-slim

# Define the Litecoin version and download URL
ARG LITECOIN_VERSION=0.21.2
ARG ZIP_TAG=x86_64-linux-gnu.tar.gz
ARG LITECOIN_URL=https://download.litecoin.org/litecoin-${LITECOIN_VERSION}/linux/litecoin-${LITECOIN_VERSION}-${ZIP_TAG}
ARG LITECOIN_SHA256_URL=https://download.litecoin.org/litecoin-${LITECOIN_VERSION}/SHA256SUMS.asc

# Install required packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends curl ca-certificates && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Download Litecoin and the checksum file
WORKDIR /tmp
RUN curl -fsSL ${LITECOIN_URL} -o litecoin-${LITECOIN_VERSION}-${ZIP_TAG} && \
    curl -fsSL ${LITECOIN_SHA256_URL} -o SHA256SUMS

RUN grep "litecoin-${LITECOIN_VERSION}-${ZIP_TAG}" SHA256SUMS | sha256sum -c -

# Extract the Litecoin binaries
RUN tar -xzvf litecoin-${LITECOIN_VERSION}-${ZIP_TAG} && \
    mv litecoin-${LITECOIN_VERSION}/bin/* /usr/local/bin/ && \
    rm -rf *

# Create a non-root user and group for security
RUN groupadd -r litecoin && useradd -r -m -g litecoin litecoin && \
    chown -R litecoin:litecoin /usr/local/bin/*

USER litecoin

# Set the default command to run Litecoin and display logs to console
CMD ["litecoind", "-printtoconsole"]
