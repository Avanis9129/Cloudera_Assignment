#!/bin/bash
source variables.sh

#configure aws and cdp
aws configure set region ${aws_region}
aws configure set aws_access_key_id ${aws_access_key}
aws configure set aws_secret_access_key ${aws_secret_key}

cdp configure set default.region ${cdp_region}
cdp configure set cdp_access_key_id ${cdp_access_key}
cdp configure set cdp_private_key ${cdp_secret_key}

#deploy cdp
cd ./cdp-tf-quickstarts/aws
terraform init
#terraform apply --auto-approve
cat terraform.tfvars
terraform plan

#deploy cml service
python -m venv ~/cdp-navigator; source ~/cdp-navigator/bin/activate;
pip install ansible-core ansible-navigator

rm -rf cloudera-deploy/
git clone https://github.com/cloudera-labs/cloudera-deploy.git; cd cloudera-deploy/public-cloud/aws/cml

sed -i 's/# name_prefix:/name_prefix: ${name_prefix}/g ; s/# admin_password:/admin_password: ${admin_password}/g ; s/infra_region:   us-east-2/infra_region: ${infra_region}/g' definition.yml

#export AWS_PROFILE=default
#export CDP_PROFILE=default

ansible-navigator run main.yml -e name_prefix=${name_prefix} -e admin_password=${admin_password} -e infra_region=${infra_region} -e public_key_id=New_key.pem
