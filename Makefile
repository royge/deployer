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
