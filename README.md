# aws-terraform

## Docker

### コンテナ削除・起動・確認

```shell
make init
```

## Terraform

envには、dev、stg、prodのいずれかを入れてください

### init

```shell
make terraform-init ENV=env
```

### plan

```shell
make terraform-plan ENV=env
```

### apply

```shell
make terraform-apply ENV=env
```

### destroy

```shell
make terraform-destroy ENV=env
```

###  fmt

```shell
make terraform-fmt
```
