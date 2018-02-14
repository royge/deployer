# The base image is alpine
FROM alpine

# Update and install packages
RUN apk update \
  && apk add ca-certificates wget \
  && update-ca-certificates

# Download terraform
RUN wget --no-check-certificate https://releases.hashicorp.com/terraform/0.11.3/terraform_0.11.3_linux_amd64.zip

# Extract terraform
RUN unzip terraform_0.11.3_linux_amd64.zip

# Move terraform binary to /usr/bin
RUN mv terraform /usr/bin/

# Download awsless binary
RUN wget --no-check-certificate https://github.com/royge/awless-bin/archive/v0.1.0.zip

# Extract awless
RUN unzip v0.1.0.zip

# Move awless to /usr/bin/
RUN mv awless-bin-0.1.0/awless /usr/bin/

# Clean up
RUN rm terraform_0.11.3_linux_amd64.zip && rm v0.1.0.zip && rm -rf awless-bin-0.1.0

CMD ["terraform", "version"]
