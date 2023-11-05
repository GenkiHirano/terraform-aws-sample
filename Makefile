# TODO: Makefile整理する

# init:
# 	terraform init

# plan:
# 	terraform plan

# apply:
# 	terraform apply

# destroy:
# 	terraform destroy

# docker-compose コマンド
# docker-compose run --rm terraform  ***

build:
	docker-compose build

fmt:
	terraform fmt -recursive