PROJECT_ID ?= stgtest-1234 # terraform workspace new {dev,stg,prd}
REPO ?= kaihendry/trunk-terraform

env: init
	terraform plan -var="project_id=$(PROJECT_ID)" -var="repo=$(REPO)"
	terraform apply -var="project_id=$(PROJECT_ID)" -var="repo=$(REPO)"

init:
	terraform init
