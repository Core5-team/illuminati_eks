.PHONY: init plan apply destroy ingress_setup

init:
	terraform init

plan: init
	terraform plan

apply: init
	terraform apply 

destroy: init
	terraform destroy 
