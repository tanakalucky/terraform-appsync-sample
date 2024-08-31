                     
<h1  style="font-weight: bold;">Terraform AppSync Sample</h1>
 
## Clone

```bash
git clone https://github.com/tanakalucky/terraform-appsync-sample.git
```
 
## Installation
```bash
npm install
```

## Build
```bash
npm run build
```

## Create Resources

### Config
 Use the `terraform.tfvars.example` as reference to create a `terraform.tfvars` file with your AWS Credentials under the terraform directory

```
access_key = "XXXXXX"
secret_key = "XXXXXX"
```

### Init
```bash
cd terraform
terraform init
```

### Plan
```bash
terraform plan
```

### Apply
```bash
terraform apply
```

## Get data
```bash
curl -s "<YOUR_GRAPHQL_URL>" \
-H "Content-Type: application/graphql" \
-H "x-api-key: <YOUR_APK_KEY>" \
-d '{ "query": "query MyQuery { get_data { id, name } }" }'
```
## Put data
```bash
curl -X POST \
  -H "Content-Type: application/json" \
  -H "x-api-key: <YOUR_API_KEY>" \
  -d '{
    "query": "mutation { put_data(id: \"testId\", name: \"testName\") }"
  }' \
  <YOUR_GRAPHQL_URL>
```
