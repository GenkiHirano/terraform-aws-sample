build:
	docker-compose build

up:
	docker-compose up -d

ps:
	docker-compose ps

stop:
	docker-compose stop

down:
	docker-compose down

# terraform-init:
# 	docker-compose run --rm --entrypoint="terraform" terraform init

terraform-fmt:
	docker-compose run --rm --entrypoint="terraform" terraform fmt -recursive

# terraform-plan:
# 	docker-compose run --rm --entrypoint="terraform" terraform plan

# terraform-apply:
# 	docker-compose run --rm --entrypoint="terraform" terraform apply

# terraform-destroy:
# 	docker-compose run --rm --entrypoint="terraform" terraform destroy
