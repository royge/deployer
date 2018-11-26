# The base image is alpine
FROM alpine

RUN apk add --no-network --no-cache --repositories-file /dev/null "apk-tools>2.10.1"

# Update and install packages
RUN apk update \
  && apk add ca-certificates wget make \
  && update-ca-certificates

# Download terraform
RUN wget --no-check-certificate https://releases.hashicorp.com/terraform/0.11.10/terraform_0.11.10_linux_amd64.zip

# Extract terraform
RUN unzip terraform_0.11.10_linux_amd64.zip

# Move terraform binary to /usr/bin
RUN mv terraform /usr/bin/

# Download awless
RUN wget --no-check-certificate https://github.com/wallix/awless/releases/download/v0.1.11/awless-linux-386.tar.gz

# Extract awless
RUN tar -xvf awless-linux-386.tar.gz

# Move awless binary to /usr/bin
RUN mv awless /usr/bin/

# Download packer
RUN wget --no-check-certificate https://releases.hashicorp.com/packer/1.1.3/packer_1.1.3_linux_amd64.zip

# Extract packer
RUN unzip packer_1.1.3_linux_amd64.zip

# Move packer binary to /usr/bin
RUN mv packer /usr/bin/

# Clean up
RUN rm terraform_0.11.10_linux_amd64.zip
RUN rm awless-linux-386.tar.gz
RUN rm packer_1.1.3_linux_amd64.zip
RUN apk del wget

CMD ["terraform", "version"]
