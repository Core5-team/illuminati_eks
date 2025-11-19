.PHONY: init plan apply destroy ingress_setup

init:
	terraform init

plan: init
	terraform plan

apply: init
	terraform apply 

destroy: init
	terraform destroy 

cert_manager_setup:
	sleep 360
	aws eks update-kubeconfig --region ${REGION} --name ${CLUSTER}
	kubectl apply \
    --validate=false \
    -f https://github.com/jetstack/cert-manager/releases/download/v1.13.5/cert-manager.yaml
	sleep 180
