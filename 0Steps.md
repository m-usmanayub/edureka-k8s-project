########################################################################################################
# THIS IS NOT A SCRIPT. DO NOT EXECUTE IT
########################################################################################################
## 1. Download all the relevant CLI tools for your OS. 
###  a. aws cli (Install procedure for Ubuntu)
`
  pip3 --version
  python3 --version
`
**  if the above commands don't work install **
`
  sudo apt-get install python3
  curl -O https://bootstrap.pypa.io/get-pip.py
  python3 get-pip.py --user
  export PATH=~/.local/bin:$PATH
  source ~/.bash_profile
  pip3 --version
  pip3 install awscli --upgrade --user
  aws --version
`
** Create an AWS user with Administrator Permissions on the account and note its Access Key and Secret access Key  **

*create two files *
`
mkdir ~/.aws
touch ~/.aws/credentials
vim ~/.aws/credentials
[default]
aws_access_key_id=<copy and paste from the UI>
aws_secret_access_key=<copy and paste from the UI>

touch ~/.aws/config
cat << 'EOF' >> ~/.aws/config
[default]
region=us-east-2
output=json
EOF
`
###  b. eksctl
`
curl --silent --location "https://github.com/weaveworks/eksctl/releases/download/latest_release/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin
eksctl version
`
###  c. aws-iam-authenticator (only needed if aws cli version is < 1.16.308)
curl -o aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.14.6/2019-08-22/bin/linux/amd64/aws-iam-authenticator
chmod +x ./aws-iam-authenticator
mkdir -p $HOME/bin && cp ./aws-iam-authenticator $HOME/bin/aws-iam-authenticator && export PATH=$HOME/bin:$PATH
echo 'export PATH=$HOME/bin:$PATH' >> ~/.bashrc
aws-iam-authenticator help
###################################################################################################
## 2. Deploy EKS Cluster using eks.yaml
`
eksctl create cluster -f eks.yaml
`
###################################################################################################
## 3. Create an EFS Storage manually
To create an Amazon EFS file system for your Amazon EKS cluster
1. Locate the VPC ID for your Amazon EKS cluster. You can find this ID in the Amazon EKS console, or you can use the following AWS CLI command.
`
aws eks describe-cluster --name ekscluster --query "cluster.resourcesVpcConfig.vpcId" --output text
Output:
vpc-0b9d876ba6f5f69c9
`
2. Locate the CIDR range for your cluster's VPC. You can find this in the Amazon VPC console, or you can use the following AWS CLI command.
`
aws ec2 describe-vpcs --vpc-ids vpc-0b9d876ba6f5f69c9 --query "Vpcs[].CidrBlock" --output text
Output:
192.168.0.0/16
`
3. Create a security group that allows inbound NFS traffic for your Amazon EFS mount points.
  a. Open the Amazon VPC console at https://console.aws.amazon.com/vpc/.
  b. Choose Security Groups in the left navigation pane, and then Create security group.
  c. Enter a name and description for your security group, and choose the VPC that your Amazon EKS cluster is using.
  d. Choose Create and then Close to finish.
  e. Add a rule to your security group to allow inbound NFS traffic from your VPC CIDR range.
  f. Choose the security group that you created in the previous step.
  g. Choose the Inbound Rules tab and then choose Edit rules.
  h. Choose Add Rule, fill out the following fields, and then choose Save rules.
      Type: NFS
      Source: Custom. Paste the VPC CIDR range.
      Description: Add a description, such as "Allows inbound NFS traffic from within the VPC."

4. Create the Amazon EFS file system for your Amazon EKS cluster.
  a. Open the Amazon Elastic File System console at https://console.aws.amazon.com/efs/.
  b. Choose Create file system.
  c. On the Configure file system access page, choose the VPC that your Amazon EKS cluster is using.
  d. For Security groups, add the security group that you created in the previous step to each mount target and choose Next step.
  e. Configure any optional settings for your file system, and then choose Next step and Create File System to finish.

###################################################################################################
## 4. Deploy Application using deploy-all.sh
###################################################################################################