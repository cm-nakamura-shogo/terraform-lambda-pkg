# Check Lambda Python Runtime Packages

## infra

```shell
cd terraform/environments/dev
bash build_lambda_layer.sh
terraform init
terraform apply # AWSへの実行権限が必要
```

## invoke

```shell
cd test
bash invoke.sh # AWSへの実行権限が必要
```