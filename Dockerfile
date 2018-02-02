# The base image is alpine
FROM alpine

# Update and install packages
RUN apk update \
  && apk add ca-certificates wget \
  && update-ca-certificates

# Download terraform
RUN wget --no-check-certificate https://releases.hashicorp.com/terraform/0.11.3/terraform_0.11.3_linux_amd64.zip

# Extract terraform
RUN unzip terraform_0.11.2_linux_amd64.zip

# Move terraform binary to /usr/bin
RUN mv terraform /usr/bin/

# Clean up
RUN rm terraform_0.11.2_linux_amd64.zip

CMD ["terraform", "version"]
