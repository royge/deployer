VERSION=1.0
build:
	docker build --pull -t deployer:latest .
	docker tag deployer:latest royge/deployer:latest
	docker tag deployer:latest royge/deployer:$(VERSION)

push:
	docker push royge/deployer:latest
	docker push royge/deployer:$(VERSION)

prepare:
	curl -LO https://storage.googleapis.com/container-structure-test/latest/container-structure-test-linux-amd64 && chmod +x container-structure-test-linux-amd64 && sudo mv container-structure-test-linux-amd64 /usr/local/bin/container-structure-test

test:
	container-structure-test test \
		--image deployer:latest \
		--config test-config.yaml

ecr-login:
	$$(aws ecr get-login --region=$(AWS_REGION) --no-include-email)

ecr-repo:
	aws ecr create-repository --repository-name deployer --region=$(AWS_REGION)

ecr-push:
	docker tag deployer:latest $(ECR_URL)/deployer:latest
	docker tag deployer:latest $(ECR_URL)/deployer:$(VERSION)
	docker push $(ECR_URL)/deployer:latest
	docker push $(ECR_URL)/deployer:$(VERSION)
