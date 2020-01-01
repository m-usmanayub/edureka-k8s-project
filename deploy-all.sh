




echo "******************************************************************************************************"
echo "*                                                                                                    *"
echo "*                                                                                                    *"
echo "*                             FOR EFS on EKS we need to change configmap's                           *"
echo "*                   file.system.id and aws.region to the values appropriate for your EFS.            *"
echo "*                                                                                                    *"
echo "*               https://aws.amazon.com/premiumsupport/knowledge-center/eks-pods-efs/                 *"
echo "*                                                                                                    *"
echo "*                                                                                                    *"
echo "******************************************************************************************************"
echo
echo
echo 
read -p "Deploying the AWS EFS CSI Storage Driver. Make sure you have whitelisted the EKS Cluster VPC "
./efs-csi.sh
echo
echo 
read -p "EFS CSI Driver Deployed"
#read -p "Please enter AWS EFS File system ID (example: fs-47a2c22e)" fs_id
echo
#read -p "Please enter AWS Region (example: us-west-2)" aws_region
echo
#read -p "Please enter Domain name for ingress routing (example: your-domain.com)" your_domain
echo
read -p "Read the EFS Storage ID"
export FILE.SYSTEM.ID=$(aws efs describe-file-systems --query "FileSystems[*].FileSystemId" --output tex)
#export FILE.SYSTEM.ID=$fs_id
export AWS.REGION="us-east-2"
#export HOST_NAME=$your_domain

./pv/pv.sh

./secret/secret.sh

./database/db.sh

echo
echo
echo "******************************************************************************************************"
echo "*                                                                                                    *"
echo "*                                                                                                    *"
echo "*                      You will be now Initialize the Database and table of MySQL                    *"
echo "*                                                                                                    *"
echo "*                                after login run the following commnads                              *"
echo "*                                                                                                    *"
echo "*                                                1.                                                  *"
echo "*                                      Create database edureka;                                      *"
echo "*                                                2.                                                  *"
echo "*                       Create table edureka(name varchar(20), email varchar(20));                   *"
echo "*                                                3.                                                  *"
echo "*                                               exit                                                 *"
echo "*                                                                                                    *"
echo "******************************************************************************************************"
echo
echo "Please enter mysql password, and run the above mentioned commands."
echo
#kubectl exec -it db-pod -- mysql -uroot -p

./frontend/frontend.sh

./ingress/ingress.sh

# echo "******************************************************************************************************"
# echo "*                                                                                                    *"
# echo "*                                                                                                    *"
# echo "*                          You can now access your website at:                                       *"
# echo "*                                                                                                    *"
# echo "*                                    $HOST_NAME/users                                                *"
# echo "*                                                                                                    *"
# echo "*                                    $HOST_NAME/admin                                                *"
# echo "*                                                                                                    *"
# echo "*                                                                                                    *"
# echo "******************************************************************************************************"
# read -p "Press any key to continue"

echo "******************************************************************************************************"
echo "*                                                                                                    *"
echo "*                                       LAST REQUIREMENT                                             *"
echo "*                                                                                                    *"
echo "* The default backend page for the ingress, should be modified to have the following data: 'Custom   *"
echo "*                                             Default Backend'                                       *"
echo "*                                                                                                    *"
echo "*               For custom ingress error page follow the steps in following article                  *"
echo "* https://github.com/kubernetes/ingress-nginx/tree/master/docs/examples/customization/custom-errors  *"
echo "*                                                                                                    *"
echo "*                                                                                                    *"
echo "******************************************************************************************************"
read -p "Press any key to End setup"