build:
	docker build --pull -t terraform:latest .
	docker tag terraform:latest royge/terraform:latest

push:
	docker push royge/terraform:latest

prepare:
	curl -LO https://storage.googleapis.com/container-structure-test/latest/container-structure-test-linux-amd64 && chmod +x container-structure-test-linux-amd64 && sudo mv container-structure-test-linux-amd64 /usr/local/bin/container-structure-test

test:
	container-structure-test test \
		--image terraform:latest \
		--config test-config.yaml

ecr-login:
	$$(aws ecr get-login --region=$(AWS_REGION) --no-include-email)

ecr-repo:
	aws ecr create-repository --repository-name terraform --region=$(AWS_REGION)

ecr-push:
	docker tag terraform:latest $(ECR_URL)/terraform:latest
	docker push $(ECR_URL)/terraform:latest
