# Makefile for Denis's Fluentd K8s deployment

# Variables
REGISTRY ?= your-registry
IMAGE_NAME ?= fluentd-denis
IMAGE_TAG ?= latest
FULL_IMAGE = $(REGISTRY)/$(IMAGE_NAME):$(IMAGE_TAG)
NAMESPACE = kube-system

.PHONY: help
help: ## Show this help message
	@echo "Denis's Fluentd K8s Deployment"
	@echo "=============================="
	@echo
	@awk 'BEGIN {FS = ":.*##"; printf "Usage: make [target]\n\nTargets:\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  %-20s %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

.PHONY: build
build: ## Build the Fluentd Docker image
	@echo "Building Fluentd image..."
	docker build -t $(FULL_IMAGE) -f Dockerfile .

.PHONY: push
push: build ## Push the image to the registry
	@echo "Pushing image to registry..."
	docker push $(FULL_IMAGE)

.PHONY: update-image
update-image: ## Update the image reference in DaemonSet
	@echo "Updating image reference in DaemonSet..."
	sed -i 's|image: .*|image: $(FULL_IMAGE)|' fluentd-daemonset.yaml

.PHONY: deploy
deploy: ## Deploy Fluentd DaemonSet to Kubernetes
	@echo "Deploying Fluentd DaemonSet..."
	kubectl apply -f fluentd-daemonset.yaml

.PHONY: deploy-example
deploy-example: ## Deploy example applications
	@echo "Deploying example applications..."
	kubectl apply -f example-app.yaml

.PHONY: logs
logs: ## Show logs from Fluentd pods
	@echo "Showing Fluentd logs..."
	kubectl logs -n $(NAMESPACE) -l k8s-app=fluentd-logging --tail=50 -f

.PHONY: restart
restart: ## Restart Fluentd DaemonSet
	@echo "Restarting Fluentd DaemonSet..."
	kubectl rollout restart daemonset/fluentd -n $(NAMESPACE)

.PHONY: status
status: ## Check status of Fluentd and example apps
	@echo "Fluentd DaemonSet status:"
	kubectl get daemonset fluentd -n $(NAMESPACE)
	@echo "\nFluentd pods:"
	kubectl get pods -n $(NAMESPACE) -l k8s-app=fluentd-logging
	@echo "\nDenis's apps:"
	kubectl get pods -l who=denis

.PHONY: clean
clean: ## Remove Fluentd DaemonSet
	@echo "Removing Fluentd DaemonSet..."
	kubectl delete -f fluentd-daemonset.yaml --ignore-not-found=true

.PHONY: clean-example
clean-example: ## Remove example applications
	@echo "Removing example applications..."
	kubectl delete -f example-app.yaml --ignore-not-found=true

.PHONY: test-logs
test-logs: ## Check if logs are being collected
	@echo "Checking logs from Denis's apps..."
	kubectl logs -l who=denis --tail=5 --all-containers=true

.PHONY: forward-metrics
forward-metrics: ## Forward Prometheus metrics port
	@echo "Forwarding metrics port (24231)..."
	@POD=$$(kubectl get pod -n $(NAMESPACE) -l k8s-app=fluentd-logging -o jsonpath='{.items[0].metadata.name}'); \
	echo "Metrics available at http://localhost:24231/metrics"; \
	kubectl port-forward -n $(NAMESPACE) $$POD 24231:24231

.PHONY: all
all: build push update-image deploy deploy-example ## Build, push, and deploy everything