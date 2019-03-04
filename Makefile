build:
	docker build --pull -t terraform:awscli .
	docker tag terraform:awscli royge/terraform:awscli

push:
	docker push royge/terraform:awscli

prepare:
	curl -LO https://storage.googleapis.com/container-structure-test/latest/container-structure-test-linux-amd64 && chmod +x container-structure-test-linux-amd64 && sudo mv container-structure-test-linux-amd64 /usr/local/bin/container-structure-test

test:
	container-structure-test test \
		--image terraform:awscli \
		--config test-config.yaml

ecr-login:
	$$(aws ecr get-login --region=us-east-1 --no-include-email)

ecr-repo:
	aws ecr create-repository --repository-name terraform --region=$(AWS_REGION)

ecr-push:
	docker tag terraform:latest $(ECR_URL)/terraform:awscli
	docker push $(ECR_URL)/terraform:awscli
