# The base image is alpine
FROM alpine

RUN apk add --no-network --no-cache --repositories-file /dev/null "apk-tools>2.10.1"

# Update and install packages
RUN apk update \
  && apk add \
    ca-certificates \
    wget \
    make \
    curl \
    openssl-dev \
    openssh-client \
  && update-ca-certificates

# Download terraform
RUN wget --no-check-certificate https://releases.hashicorp.com/terraform/0.11.10/terraform_0.11.10_linux_amd64.zip

# Extract terraform
RUN unzip terraform_0.11.10_linux_amd64.zip

# Move terraform binary to /usr/bin
RUN mv terraform /usr/bin/

# Download packer
RUN wget --no-check-certificate https://releases.hashicorp.com/packer/1.1.3/packer_1.1.3_linux_amd64.zip

# Extract packer
RUN unzip packer_1.1.3_linux_amd64.zip

# Move packer binary to /usr/bin
RUN mv packer /usr/bin/

# Install jq 1.6
RUN curl -LO \
    https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64 && \
    chmod +x jq-linux64 && \
    mv jq-linux64 /usr/local/bin/jq

# Install aws cli
RUN apk add --update py-pip
RUN pip install awscli

# Clean up
RUN rm terraform_0.11.10_linux_amd64.zip
RUN rm packer_1.1.3_linux_amd64.zip
RUN apk del wget

CMD ["terraform", "version"]
