#!/usr/bin/env bash

declare region="us-west-1"
declare -a dependencies=("jq" "aws")

for dep in "${dependencies[@]}"
do
    if [ "$(which ${dep})" = "" ] ;then
        echo "This script requires the ${dep} utility. Please install it and try again."
        exit 1
    fi
done

aws lambda delete-function --function-name=hello_claudia --region=$region
for apiId in $(aws apigateway get-rest-apis --output=json --region=$region | jq '.items[].id' | xargs);
do
    aws apigateway delete-rest-api --rest-api-id=$apiId --region=$region
done
aws iam delete-role-policy --role-name hello_claudia-executor --policy-name log-writer
aws iam delete-role --role-name=hello_claudia-executor