DOCKER_REGISTRY=rg.fr-par.scw.cloud
DOCKER_REGISTRY_NS=cors-demo

.PHONY: create-namespace
create-namespace:
	scw registry namespace create name=$(DOCKER_REGISTRY_NS)

.PHONY: docker-login
docker-login:
	scw registry login

.PHONY: build-server
build-server:
	cd server && docker build -t $(DOCKER_REGISTRY)/$(DOCKER_REGISTRY_NS)/server:0.0.1 .

.PHONY: build-gateway
build-gateway:
	cd server && docker build -t $(DOCKER_REGISTRY)/$(DOCKER_REGISTRY_NS)/gateway:0.0.1 .

.PHONY: push-server
push-server:
	docker push $(DOCKER_REGISTRY)/$(DOCKER_REGISTRY_NS)/server:0.0.1

.PHONY: push-gateway
push-gateway:
	docker push $(DOCKER_REGISTRY)/$(DOCKER_REGISTRY_NS)/gateway:0.0.1

.PHONY: tf-init
tf-init:
	cd terraform && terraform init

.PHONY: tf-plan
tf-plan:
	cd terraform && terraform plan -var-file=vars/main.tfvars

.PHONY: tf-apply
tf-apply:
	cd terraform && terraform apply -var-file=vars/main.tfvars

