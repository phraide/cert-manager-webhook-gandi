IMAGE_NAME := "phraide/cert-manager-webhook-gandi"
IMAGE_TAG := "v0.2.0"

OUT := $(shell pwd)/_out

$(shell mkdir -p "$(OUT)")

verify:
	go test -v .

build-arm64:
	docker build --rm -t "$(IMAGE_NAME):$(IMAGE_TAG)-arm64" -f Dockerfile.arm64 .

build-amd64:
	docker build --rm -t "$(IMAGE_NAME):$(IMAGE_TAG)-amd64" -f Dockerfile.amd64 .

.PHONY: rendered-manifest.yaml
rendered-manifest.yaml:
#	    --name cert-manager-webhook-gandi $BACKSLASH
	helm template \
        --set image.repository=$(IMAGE_NAME) \
        --set image.tag=$(IMAGE_TAG) \
        deploy/cert-manager-webhook-gandi > "$(OUT)/rendered-manifest.yaml"
