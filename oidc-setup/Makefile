PROJECT_ID ?= devtest-1234
REPO ?= kaihendry/trunk-terraform

env: init
	terraform plan -var="project_id=$(PROJECT_ID)" -var="repo=$(REPO)"
	terraform apply -var="project_id=$(PROJECT_ID)" -var="repo=$(REPO)"

init:
	terraform init
