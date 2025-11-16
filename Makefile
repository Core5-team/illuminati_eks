.PHONY: init plan apply destroy
init:
	terraform init
plan: init
	terraform plan    -var-file=development_varibles.tfvars

apply: init
	terraform apply   -var-file=development_varibles.tfvars
destroy: init
	terraform destroy -var-file=development_varibles.tfvars